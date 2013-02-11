#import <MobileCoreServices/MobileCoreServices.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "AFHTTPClient.h"
#import "AFNetworking.h"

@class LUAPIRequest;

typedef void (^LUAPISuccessBlock)(id result);
typedef void (^LUAPIFailureBlock)(NSError *error);

#define LUAPIFailingURLRequestErrorKey AFNetworkingOperationFailingURLRequestErrorKey
#define LUAPIFailingURLResponseErrorKey AFNetworkingOperationFailingURLResponseErrorKey

extern NSString * const LUAPIFailingJSONResponseErrorKey;
extern NSString * const LUAPIFailingErrorMessageErrorKey;

extern NSString * const DefaultLevelUpApiURL;

@interface LUAPIClient : AFHTTPClient

@property (copy) NSString *accessToken;
@property (copy, readonly) NSString *apiKey;
@property (readwrite, nonatomic, strong) NSURL *baseURL;
@property (copy) NSNumber *currentUserId;
@property (assign, readonly) BOOL developmentMode;

+ (LUAPIClient *)sharedClient;

+ (void)setupWithAPIKey:(NSString *)apiKey developmentMode:(BOOL)developmentMode;
- (BOOL)isNetworkUnreachable;
- (NSOperation *)performRequest:(LUAPIRequest *)apiRequest
                        success:(LUAPISuccessBlock)success
                        failure:(LUAPIFailureBlock)failure;

@end
