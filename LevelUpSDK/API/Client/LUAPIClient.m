#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUJSONDeserializer.h"

NSString * const LUAPIFailingJSONResponseErrorKey = @"LUAPIFailingJSONResponseErrorKey";
NSString * const LUAPIFailingErrorMessageErrorKey = @"LUAPIFailingErrorMessageErrorKey";

NSString * const DefaultLevelUpApiURL = @"https://api.thelevelup.com/v13";

@implementation LUAPIClient

#pragma mark -
#pragma mark Creation/Removal Methods

+ (LUAPIClient *)sharedClient {
  static dispatch_once_t pred = 0;
  __strong static id _sharedObject = nil;
  dispatch_once(&pred, ^{
    @autoreleasepool {
      _sharedObject = [[LUAPIClient alloc] initWithBaseURL:[NSURL URLWithString:DefaultLevelUpApiURL]];
    }
  });
  return _sharedObject;
}

- (id)initWithBaseURL:(NSURL *)url {
  self = [super initWithBaseURL:url];

  if (self) {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
  }

  return self;
}

#pragma mark -
#pragma mark Public Methods

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

#pragma mark -
#pragma mark Private Methods

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
