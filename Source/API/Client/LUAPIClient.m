#import "LUAbstractJSONModelFactory.h"
#import "LUAPIClient.h"
#import "LUAPIConnection.h"
#import "LUAPIErrorBuilder.h"
#import "LUAPIRequest.h"
#import "LUAPIResponse.h"
#import "LUConstants.h"

@interface LUAPIClient ()

@property (copy, readwrite) NSString *apiKey;
@property (assign, readwrite) BOOL developmentMode;

@end

@implementation LUAPIClient

__strong static id _sharedClient = nil;

#pragma mark - Object Lifecycle Methods

+ (LUAPIClient *)sharedClient {
  NSAssert(_sharedClient != nil, @"setupWithAppID:APIKey:developmentMode: must be called before sharedClient");

  return _sharedClient;
}

- (id)initWithAppID:(NSString *)appID APIKey:(NSString *)apiKey developmentMode:(BOOL)developmentMode {
  NSAssert(appID.length > 0, @"An app ID is required");
  NSAssert(apiKey.length > 0, @"An API key is required");

  NSURL *baseURL;
  if (developmentMode) {
    baseURL = [NSURL URLWithString:LevelUpAPIBaseURLDevelopment];
  } else {
    baseURL = [NSURL URLWithString:LevelUpAPIBaseURLProduction];
  }

  self = [super initWithBaseURL:baseURL];
  if (self) {
    _appID = appID;
    _apiKey = apiKey;
    _developmentMode = developmentMode;

    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    [self setDefaultHeader:@"User-Agent" value:[self userAgent]];
    [self setParameterEncoding:AFJSONParameterEncoding];
  }

  return self;
}

#pragma mark - Public Methods

+ (void)setupWithAppID:(NSString *)appID APIKey:(NSString *)apiKey developmentMode:(BOOL)developmentMode {
  _sharedClient = [[self alloc] initWithAppID:appID APIKey:apiKey developmentMode:developmentMode];
}

- (LUAPIConnection *)performRequest:(LUAPIRequest *)apiRequest
                            success:(LUAPISuccessBlock)success
                            failure:(LUAPIFailureBlock)failure {
  AFJSONRequestOperation *requestOperation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:apiRequest.urlRequest
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

  [self enqueueHTTPRequestOperation:requestOperation];

  return [[LUAPIConnection alloc] initWithAFHTTPRequestOperation:requestOperation];
}

#pragma mark - Private Methods

- (NSString *)userAgent {
  return [[self defaultValueForHeader:@"User-Agent"] stringByAppendingFormat:@" LevelUpSDK/%@", LevelUpSDKVersion];
}

@end
