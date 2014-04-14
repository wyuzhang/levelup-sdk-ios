// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "AFHTTPClient.h"
#import "AFNetworking.h"
#import "LUAbstractJSONModelFactory.h"
#import "LUAPIClient.h"
#import "LUAPIConnection.h"
#import "LUAPIErrorBuilder.h"
#import "LUAPIRequest.h"
#import "LUAPIResponse.h"
#import "LUConstants.h"

@interface LUAPIClient ()

@property (strong) AFHTTPClient *httpClient;
@property (copy, readwrite) NSString *apiKey;
@property (assign, readwrite) BOOL developmentMode;

@end

@implementation LUAPIClient

__strong static LUAPIClient *_sharedClient = nil;

#pragma mark - Object Lifecycle Methods

+ (LUAPIClient *)sharedClient {
  NSAssert(_sharedClient != nil, @"setupWithAppID:APIKey: must be called before sharedClient");

  return _sharedClient;
}

- (id)initWithAppID:(NSString *)appID APIKey:(NSString *)apiKey developmentMode:(BOOL)developmentMode {
  NSAssert(appID.length > 0, @"An app ID is required");
  NSAssert(apiKey.length > 0, @"An API key is required");

  self = [super init];
  if (!self) return nil;

  _appID = appID;
  _apiKey = apiKey;
  _deepLinkAuthBundleID = @"com.scvngr.LevelUp";
  _deepLinkAuthURLScheme = @"thelevelup";
  _developmentMode = developmentMode;

  if (developmentMode) {
    _clientsideEncryptionKey = BraintreePublicKeyDevelopment;
  } else {
    _clientsideEncryptionKey = BraintreePublicKeyProduction;
  }

  [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;

  if (developmentMode) {
    _baseURL = [NSURL URLWithString:LevelUpAPIBaseURLDevelopment];
  } else {
    _baseURL = [NSURL URLWithString:LevelUpAPIBaseURLProduction];
  }

  _httpClient = [[AFHTTPClient alloc] initWithBaseURL:_baseURL];
  [_httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
  [_httpClient setDefaultHeader:@"Accept" value:@"application/json"];
  [_httpClient setDefaultHeader:@"User-Agent" value:[self userAgent]];
  [_httpClient setParameterEncoding:AFJSONParameterEncoding];

  return self;
}

#pragma mark - Public Methods

+ (void)setupWithAppID:(NSString *)appID APIKey:(NSString *)apiKey {
  [self setupWithAppID:appID APIKey:apiKey developmentMode:NO];
}

+ (void)setupWithAppID:(NSString *)appID APIKey:(NSString *)apiKey developmentMode:(BOOL)developmentMode {
  _sharedClient = [[self alloc] initWithAppID:appID APIKey:apiKey developmentMode:developmentMode];
}

- (BOOL)isNetworkUnreachable {
  return self.httpClient.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable;
}

- (LUAPIConnection *)performRequest:(LUAPIRequest *)apiRequest
                            success:(LUAPISuccessBlock)success
                            failure:(LUAPIFailureBlock)failure {
  AFJSONRequestOperation *requestOperation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:apiRequest.URLRequest
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                      if (success) {
                                                        LUAPIResponse *apiResponse = [[LUAPIResponse alloc] initWithHTTPURLResponse:response];

                                                        if (apiRequest.modelFactory) {
                                                          success([apiRequest.modelFactory fromJSONObject:JSON], apiResponse);
                                                        } else {
                                                          success(JSON, apiResponse);
                                                        }
                                                      }
                                                    }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                      if (failure) {
                                                        failure([LUAPIErrorBuilder error:error withMessagesFromJSON:JSON]);
                                                      }
                                                    }];

  [self.httpClient enqueueHTTPRequestOperation:requestOperation];

  return [[LUAPIConnection alloc] initWithAFHTTPRequestOperation:requestOperation];
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      path:(NSString *)path
                                parameters:(NSDictionary *)parameters {
  return [self.httpClient requestWithMethod:method path:path parameters:parameters];
}

#pragma mark - Private Methods

- (NSString *)userAgent {
  return [[self.httpClient defaultValueForHeader:@"User-Agent"] stringByAppendingFormat:@" LevelUpSDK/%@", LevelUpSDKVersion];
}

@end
