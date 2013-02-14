/**
 `LUOAuthTokenRequestBuilder` is used to build requests related to OAuth Tokens (for authentication).
 */
@class LUAPIRequest;

@interface LUOAuthTokenRequestBuilder : NSObject

/**
 Builds a request to login via an email and password.

 On success, this request will return an `LUOAuthToken` instance.

 @param email The email address to use for the login.
 @param password The password to use for the login.
 */
+ (LUAPIRequest *)requestToLoginWithEmail:(NSString *)email password:(NSString *)password;

/**
 Builds a request to login via a Facebook access token.

 On success, this request will return an `LUOAuthToken` instance.

 @param facebookAccessToken The Facebook access token to use for the login.
 */
+ (LUAPIRequest *)requestToLoginWithFacebookAccessToken:(NSString *)facebookAccessToken;

@end
