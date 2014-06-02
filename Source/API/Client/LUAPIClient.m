// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "AFNetworkActivityIndicatorManager.h"
#import "AFNetworking.h"
#import "LUAbstractJSONModelFactory.h"
#import "LUAPIClient.h"
#import "LUAPIConnection.h"
#import "LUAPIErrorBuilder.h"
#import "LUAPIRequest.h"
#import "LUAPIResponse.h"
#import "LUConstants.h"
#import "LUKeychainAccess.h"

NSString * const LUAccessTokenKey = @"LUAccessToken";
NSString * const LUCurrentUserIDKey = @"LUCurrentUserID";

@interface LUAPIClient ()

@property (copy, readwrite) NSString *apiKey;
@property (assign, readwrite) BOOL developmentMode;
@property (strong) AFHTTPRequestOperationManager *httpOperationManager;

@end

@implementation LUAPIClient {
  NSString *_accessToken;
  NSNumber *_currentUserID;
}

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

  _apiKey = apiKey;
  _appID = appID;
  _deepLinkAuthBundleID = @"com.scvngr.LevelUp";
  _deepLinkAuthInstallAppStoreURL = [NSURL URLWithString:@"https://itunes.apple.com/us/app/levelup-.-pay-with-your-phone/id424121785"];
  _deepLinkAuthInstallMessage = @"It looks like you don’t have the LevelUp app installed, but that’s an easy fix! It’s easy to set up and free.";
  _deepLinkAuthInstallNegativeButtonTitle = @"No Thanks";
  _deepLinkAuthInstallPositiveButtonTitle = @"Get LevelUp";
  _deepLinkAuthInstallTitle = @"Get LevelUp";
  _deepLinkAuthShowInstallAlert = YES;
  _deepLinkAuthURLScheme = @"thelevelup";
  _developmentMode = developmentMode;

  if (developmentMode) {
    _clientsideEncryptionKey = BraintreePublicKeyDevelopment;
  } else {
    _clientsideEncryptionKey = BraintreePublicKeyProduction;
  }

  [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;

  NSURL *baseURL;
  if (developmentMode) {
    baseURL = [NSURL URLWithString:LevelUpAPIBaseURLDevelopment];
  } else {
    baseURL = [NSURL URLWithString:LevelUpAPIBaseURLProduction];
  }

  AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
  [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  NSString *defaultUserAgent = requestSerializer.HTTPRequestHeaders[@"User-Agent"];
  [requestSerializer setValue:[defaultUserAgent stringByAppendingFormat:@" LevelUpSDK/%@", LevelUpSDKVersion]
           forHTTPHeaderField:@"User-Agent"];

  _httpOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
  _httpOperationManager.requestSerializer = requestSerializer;
  _httpOperationManager.responseSerializer = [AFJSONResponseSerializer serializer];

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
  return self.httpOperationManager.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable;
}

- (LUAPIConnection *)performRequest:(LUAPIRequest *)apiRequest
                            success:(LUAPISuccessBlock)success
                            failure:(LUAPIFailureBlock)failure {
  AFHTTPRequestOperation *requestOperation =
    [self.httpOperationManager HTTPRequestOperationWithRequest:apiRequest.URLRequest
                                                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                         if (success) {
                                                           LUAPIResponse *apiResponse = [[LUAPIResponse alloc] initWithHTTPURLResponse:operation.response];

                                                           if (apiRequest.modelFactory) {
                                                             success([apiRequest.modelFactory fromJSONObject:responseObject], apiResponse);
                                                           } else {
                                                             success(responseObject, apiResponse);
                                                           }
                                                         }
                                                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                         if (failure) {
                                                           failure([LUAPIErrorBuilder error:error withMessagesFromJSON:operation.responseObject]);
                                                         }
                                                       }];
  [self.httpOperationManager.operationQueue addOperation:requestOperation];

  return [[LUAPIConnection alloc] initWithAFHTTPRequestOperation:requestOperation];
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      path:(NSString *)path
                                parameters:(NSDictionary *)parameters {
  NSString *URLString = [[NSURL URLWithString:path relativeToURL:self.httpOperationManager.baseURL] absoluteString];
  return [self.httpOperationManager.requestSerializer requestWithMethod:method URLString:URLString parameters:parameters error:nil];
}

- (NSString *)userAgent {
  return self.httpOperationManager.requestSerializer.HTTPRequestHeaders[@"User-Agent"];
}

#pragma mark - Property Methods

- (NSString *)accessToken {
  if (!_accessToken) {
    _accessToken = [[LUKeychainAccess standardKeychainAccess] stringForKey:LUAccessTokenKey];
  }

  return _accessToken;
}

- (NSURL *)baseURL {
  return self.httpOperationManager.baseURL;
}

- (NSNumber *)currentUserID {
  if (!_currentUserID) {
    _currentUserID = [[LUKeychainAccess standardKeychainAccess] objectForKey:LUCurrentUserIDKey];
  }

  return _currentUserID;
}

- (void)setAccessToken:(NSString *)accessToken {
  _accessToken = accessToken;
  [[LUKeychainAccess standardKeychainAccess] setString:accessToken forKey:LUAccessTokenKey];
}

- (void)setBaseURL:(NSURL *)baseURL {
  [self.httpOperationManager setValue:baseURL forKeyPath:@"baseURL"];
}

- (void)setCurrentUserID:(NSNumber *)currentUserID {
  _currentUserID = currentUserID;
  [[LUKeychainAccess standardKeychainAccess] setObject:currentUserID forKey:LUCurrentUserIDKey];
}

@end
