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

@interface LUAPIClient : AFHTTPClient

@property (copy) NSString *accessToken;
@property (readwrite, nonatomic, strong) NSURL *baseURL;
@property (copy) NSNumber *currentUserId;
@property (copy) NSString *levelUpClientId;

+ (LUAPIClient *)sharedClient;

- (BOOL)isNetworkUnreachable;
- (NSOperation *)performRequest:(LUAPIRequest *)apiRequest
                        success:(LUAPISuccessBlock)success
                        failure:(LUAPIFailureBlock)failure;

@end
