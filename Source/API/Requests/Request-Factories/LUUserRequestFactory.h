// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

/**
 `LUTicketRequestFactory` is used to build requests related to users.
 */
@class LUAPIRequest;
@class LUUser;

@interface LUUserRequestFactory : NSObject

/**
 Builds a request to return the current user. This is a convenience method to call +requestForUserWithID: with the userID of the cached user object.

 On success, this request will return an `LUUser` instance.
 */
+ (LUAPIRequest *)requestForCurrentUser;

/**
 Builds a request to fetch the user with the given user ID.

 On success, this request will return an `LUUser` instance.

 @param userID The ID for the user requested.
 */
+ (LUAPIRequest *)requestForUserWithID:(NSNumber *)userID;

/**
 Builds a request to connect the current user to Facebook.

 On success, this request will return the connected `LUUser`.

 @param facebookAccessToken A Facebook access token.
 */
+ (LUAPIRequest *)requestToConnectToFacebookWithAccessToken:(NSString *)facebookAccessToken;

/**
 Builds a request to create a user.

 On success, this request will return the newly created `LUUser`.

 @param user The `LUUser` to create.
 */
+ (LUAPIRequest *)requestToCreateUser:(LUUser *)user;

/**
 Builds a request to create a user using a Facebook access token.

 On success, this request will return the newly created `LUUser`. This request will fail if a user already exists with
 the given access token. In that case, the `requestToLoginWithFacebookAccessToken:` method in
 `LUAuthenticationRequestFactory` should be used instead.

 @param facebookAccessToken The Facebook access token.
 */
+ (LUAPIRequest *)requestToCreateUserWithFacebookAccessToken:(NSString *)facebookAccessToken;

/**
 Builds a request to disconnect the current user from Facebook.

 On success, this request will return the disconnected `LUUser`.
*/
+ (LUAPIRequest *)requestToDisconnectFromFacebook;

/**
 Builds a request to reset the password of a user.

 On success, this request will return `nil`.

 @param email An email address.
 */
+ (LUAPIRequest *)requestToResetPasswordWithEmail:(NSString *)email;

/**
 Builds a request to update a user.

 On success, this request will return the updated `LUUser`.

 @param user The `LUUser` to update.
 */
+ (LUAPIRequest *)requestToUpdateUser:(LUUser *)user;

@end
