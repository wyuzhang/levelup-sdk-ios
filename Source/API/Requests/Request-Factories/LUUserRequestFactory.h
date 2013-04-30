/**
 `LUTicketRequestFactory` is used to build requests related to users.
 */
@class LUAPIRequest;
@class LUUser;

@interface LUUserRequestFactory : NSObject

/**
 Builds a request to return the current user.

 On success, this request will return an `LUUser` instance.
 */
+ (LUAPIRequest *)requestForCurrentUser;

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
 Builds a request to disconnect the current user from Facebook.

 On success, this request will return the disconnected `LUUser`.
*/
+ (LUAPIRequest *)requestToDisconnectFromFacebook;

/**
 Builds a request to remove the current user's cause affiliation.

 On success, this request will return `nil`.
 */
+ (LUAPIRequest *)requestToRemoveCauseAffiliation;

/**
 Builds a request to reset the password of a user.

 On success, this request will return `nil`.

 @param email An email address.
 */
+ (LUAPIRequest *)requestToResetPasswordWithEmail:(NSString *)email;

/**
 Builds a request to set the current user's cause.

 On success, this request will return `nil`.

 @param causeId The ID of an `LUCause`.
 */
+ (LUAPIRequest *)requestToSetCauseId:(NSNumber *)causeId;

/**
 Builds a request to update a user.

 On success, this request will return the updated `LUUser`.

 @param user The `LUUser` to update.
 */
+ (LUAPIRequest *)requestToUpdateUser:(LUUser *)user;

@end
