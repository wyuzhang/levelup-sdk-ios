// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import <MobileCoreServices/MobileCoreServices.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "AFHTTPClient.h"
#import "AFNetworking.h"

/**
 `LUAPIClient` is used to perform requests to the LevelUp API.

 ## Setup

 Before using `LUAPIClient`, it must be set up with a valid API key. This is done with `setupWithAppID:APIKey:`.

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
 object containing additional information about the error. This error will have the domain `LUAPIErrorDomain`.

 ### Codes

 The error may have one of the following codes:

 - `LUAPIErrorLoginRequired`: The client must be logged in to complete the request.
 - `LUAPIErrorMaintenance`: The server is currently down for maintenance.
 - `LUAPIErrorNetwork`: Was unable to get to the server because the network is down.
 - `LUAPIErrorParsing`: The server responded with JSON that couldn't be parsed.
 - `LUAPIErrorServer`: The server responded with an error.
 - `LUAPIErrorUpgrade`: The SDK needs to be upgraded.

 ### User Info

 The `userInfo` dictionary for this `NSError` has keys for several pieces of information:

 - `LUAPIErrorKeyAPIErrors`: An optional array of `LUAPIError` objects returned by the server.
 - `LUAPIErrorKeyErrorMessage`: An optional error message from the server. If multiple errors were returned, this will
 only contain the first message. `LUAPIErrorKeyAPIErrors` can be used to see all errors.
 - `LUAPIErrorKeyJSONResponse`: An optional JSON response from the server.
 - `LUAPIErrorKeyOriginalError`: If this error was generated from another `NSError`, it is included under this key.
 - `LUAPIErrorKeyURLResponse`: An `NSURLResponse` containing the response.

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

@class LUAPIConnection;
@class LUAPIRequest;
@class LUAPIResponse;

typedef void (^LUAPISuccessBlock)(id result, LUAPIResponse *response);
typedef void (^LUAPIFailureBlock)(NSError *error);

@interface LUAPIClient : AFHTTPClient

///-------------------------------
/// @name Configuration
///-------------------------------

/**
 Sets up the LevelUp SDK.

 This method must be called before performing any API requests.

 @param appID Your LevelUp App ID.
 @param apiKey Your LevelUp API key.
 */
+ (void)setupWithAppID:(NSString *)appID APIKey:(NSString *)apiKey;

/**
 Sets up the LevelUp SDK with the option of turning on development mode (internal use only).

 Using `setupWithAppID:APIKey:` is preferred, as development mode uses the LevelUp staging server which may
 not be up to date with all API keys, as well as periodic downtime or possible bugs.

 @param appID Your LevelUp App ID.
 @param apiKey Your LevelUp API key.
 @param developmentMode Specifies if requests should go to the development or production server.
 */
+ (void)setupWithAppID:(NSString *)appID APIKey:(NSString *)apiKey developmentMode:(BOOL)developmentMode;

/**
 The access token of an authenticated user.
 */
@property (copy) NSString *accessToken;

/**
 The user ID of the authenticated user.
 */
@property (copy) NSNumber *currentUserID;

@property (copy, readonly) NSString *apiKey;
@property (copy, readonly) NSString *appID;
@property (nonatomic, strong) NSURL *baseURL;
@property (nonatomic, copy) NSString *clientsideEncryptionKey;
@property (assign, readonly) BOOL developmentMode;

///-------------------------------
/// @name Getters
///-------------------------------

/**
 Returns the `User-Agent` string containing the app name and version, device name and version and LevelUpSDK version.

 @return An `NSString` containing the `User-Agent` data.
 */
- (NSString *)userAgent;

///-------------------------------
/// @name Performing Requests
///-------------------------------

/**
 Returns the `LUAPIClient` singleton used to issue API requests.

 @return The shared `LUAPIClient` instance.

 @exception NSInternalInconsistencyException If this method is called before `setupWithAppID:APIKey:`.
 */
+ (LUAPIClient *)sharedClient;

/**
 Initiates a LevelUp API request.

 @param apiRequest The API request to perform. Request builders can be used to generate these objects.
 @param success A block to be called upon successful completion of the API request. This block takes a single argument,
 which is the result of the API call. The type of the object depends on the specific API request.
 @param failure A block to be called if the API call fails. This block takes a single argument, which is an `NSError`
 containing additional information about the error.

 @return An `LUAPIConnection` for the request.
 */
- (LUAPIConnection *)performRequest:(LUAPIRequest *)apiRequest
                            success:(LUAPISuccessBlock)success
                            failure:(LUAPIFailureBlock)failure;

@end
