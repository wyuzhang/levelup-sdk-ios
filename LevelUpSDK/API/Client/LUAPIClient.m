#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUConstants.h"
#import "LUJSONDeserializer.h"

NSString * const LUAPIFailingJSONResponseErrorKey = @"LUAPIFailingJSONResponseErrorKey";
NSString * const LUAPIFailingErrorMessageErrorKey = @"LUAPIFailingErrorMessageErrorKey";

@interface LUAPIClient ()

@property (copy, readwrite) NSString *apiKey;
@property (assign, readwrite) BOOL developmentMode;

@end

@implementation LUAPIClient

__strong static id _sharedClient = nil;

#pragma mark - Object Lifecycle Methods

+ (LUAPIClient *)sharedClient {
  NSAssert(_sharedClient != nil, @"setupWithAPIKey:developmentMode: must be called before sharedClient");

  return _sharedClient;
}

- (id)initWithAPIKey:(NSString *)apiKey developmentMode:(BOOL)developmentMode {
  NSURL *baseURL;
  if (developmentMode) {
    baseURL = [NSURL URLWithString:LevelUpAPIBaseURLDevelopment];
  } else {
    baseURL = [NSURL URLWithString:LevelUpAPIBaseURLProduction];
  }

  self = [super initWithBaseURL:baseURL];
  if (self) {
    _apiKey = apiKey;
    _developmentMode = developmentMode;

    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
  }

  return self;
}

#pragma mark - Public Methods

+ (void)setupWithAPIKey:(NSString *)apiKey developmentMode:(BOOL)developmentMode {
  _sharedClient = [[self alloc] initWithAPIKey:apiKey developmentMode:developmentMode];
}

- (BOOL)isNetworkUnreachable {
  return self.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable;
}

- (NSOperation *)performRequest:(LUAPIRequest *)apiRequest
                        success:(LUAPISuccessBlock)success
                        failure:(LUAPIFailureBlock)failure {
  AFJSONRequestOperation *requestOperation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:apiRequest.urlRequest
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                      if (success) {
                                                        success([LUJSONDeserializer deserializeJSON:JSON]);
                                                      }
                                                    }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                      if (failure) {
                                                        failure([self error:error withMessagesFromJSON:JSON]);
                                                      }
                                                    }];

  [self enqueueHTTPRequestOperation:requestOperation];

  return requestOperation;
}

#pragma mark - Private Methods

- (NSError *)error:(NSError *)error withMessagesFromJSON:(id)JSON {
  NSMutableDictionary *userInfo = [error.userInfo mutableCopy];

  if (JSON) {
    userInfo[LUAPIFailingJSONResponseErrorKey] = JSON;

    if ([JSON isKindOfClass:[NSDictionary class]]) {
      NSDictionary *responseDict = (NSDictionary *)JSON;

      if (responseDict[@"error_description"]) {
        userInfo[LUAPIFailingErrorMessageErrorKey] = responseDict[@"error_description"];
      } else if(responseDict[@"error"]) {
        userInfo[LUAPIFailingErrorMessageErrorKey] = responseDict[@"error"];
      }
    }
  }

  return [NSError errorWithDomain:error.domain code:error.code userInfo:userInfo];
}

@end
