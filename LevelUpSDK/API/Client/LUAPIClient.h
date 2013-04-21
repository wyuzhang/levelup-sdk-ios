#import <MobileCoreServices/MobileCoreServices.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "AFHTTPClient.h"
#import "AFNetworking.h"

/**
 `LUAPIClient` is used to perform requests to the LevelUp API.

 ## Setup

 Before using `LUAPIClient`, it must be set up with a valid API key. This is done with `setupWithAPIKey:developmentMode:`.

 ## Issuing Requests

 The method `performRequest:success:failure:` is used to issue requests to the LevelUp's REST API. It uses
 [AFNetworking](https://github.com/AFNetworking/AFNetworking) to perform these requests in the background, and then
 handle responses. If the request is successful, the `success` block is called, passing in the result of the API call.
 If an error occurs, the `failure` block is called with an appropriate `NSError`.

 A API request is an instance of `LUAPIRequest` which has been generated using a request builder class. See the
 documentation for the request builder for information on specific API calls.

 ## Authentication

 When a user logs in, an access token is provided along with the user's ID. `LUAPIClient` needs to be given these values
 so that they can be included in API calls which require an authenticated user.

 The application is responsible for securely storing these values so that when the application launches, users will
 remain logged in. As part of launching your application, you may set these values using the `accessToken` and
 `currentUserID` properties.

 ## Errors

 When an API call fails, the `failure` block passed to `performRequest:success:failure:` will be called with an `NSError`
 object containing additional information about the error. The `userInfo` dictionary for this `NSError` has keys
 for several pieces of information:

 - `LUAPIFailingURLRequestErrorKey`: An `NSURLRequest` containing the request.
 - `LUAPIFailingURLResponseErrorKey`: An `NSURLResponse` containing the response.
 - `LUAPIFailingErrorMessageErrorKey`: An optional error message from the server.
 - `LUAPIFailingJSONResponseErrorKey`: An optional JSON response from the server.

 ## Example

    LUAPIRequest *request = [LUUserRequestFactory requestForCurrentUser];
    [[LUAPIClient sharedClient] performRequest:request
                                       success:^(LUUser *user) {
                                         NSLog(@"The current user is %@", user);
                                       }
                                       failure:^(NSError *error) {
                                         NSLog(@"Got an error: %@", error);
                                       }];
 */

@class LUAPIRequest;

typedef void (^LUAPISuccessBlock)(id result);
typedef void (^LUAPIFailureBlock)(NSError *error);

#define LUAPIFailingURLRequestErrorKey AFNetworkingOperationFailingURLRequestErrorKey
#define LUAPIFailingURLResponseErrorKey AFNetworkingOperationFailingURLResponseErrorKey

extern NSString * const LUAPIFailingJSONResponseErrorKey;
extern NSString * const LUAPIFailingErrorMessageErrorKey;

extern NSString * const DefaultLevelUpApiURL;

@interface LUAPIClient : AFHTTPClient

///-------------------------------
/// @name Configuration
///-------------------------------

/**
 Sets up the LevelUp SDK.

 This method must be called before performing any API requests.

 @param apiKey Your LevelUp API key.
 @param developmentMode Specifies if requests should go to sandbox or production.
 */
+ (void)setupWithAPIKey:(NSString *)apiKey developmentMode:(BOOL)developmentMode;

/**
 The access token of an authenticated user.
 */
@property (copy) NSString *accessToken;

/**
 The user ID of the authenticated user.
 */
@property (copy) NSNumber *currentUserID;

@property (copy, readonly) NSString *apiKey;
@property (readwrite, nonatomic, strong) NSURL *baseURL;
@property (assign, readonly) BOOL developmentMode;

///-------------------------------
/// @name Performing Requests
///-------------------------------

/**
 Returns the `LUAPIClient` singleton used to issue API requests.

 @return The shared `LUAPIClient` instance.

 @exception NSInternalInconsistencyException If this method is called before `setupWithAPIKey:developmentMode:`.
 */
+ (LUAPIClient *)sharedClient;

/**
 Initiates a LevelUp API request.

 @param apiRequest The API request to perform. Request builders can be used to generate these objects.
 @param success A block to be called upon successful completion of the API request. This block takes a single argument,
 which is the result of the API call. The type of the object depends on the specific API request.
 @param failure A block to be called if the API call fails. This block takes a single argument, which is an `NSError`
 containing additional information about the error.

 @return An NSOperation for the request.
 */
- (NSOperation *)performRequest:(LUAPIRequest *)apiRequest
                        success:(LUAPISuccessBlock)success
                        failure:(LUAPIFailureBlock)failure;

/**
 Specifies if the network is currently unreachable. This can be useful for giving the user relevant information about
 API errors.
 */
- (BOOL)isNetworkUnreachable;

@end
