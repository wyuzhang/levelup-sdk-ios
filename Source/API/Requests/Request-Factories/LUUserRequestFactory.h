// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@class LUAPIRequest;
@class LUUser;

/**
 `LUTicketRequestFactory` is used to build requests related to users.
 */
@interface LUUserRequestFactory : NSObject

/**
 Builds a request to return the current user. This is a convenience method to call
 `requestForUserWithID:` with the userID of the cached user object.

 On success, this request will return an `LUUser` instance.
 @warning This request requires an access token with the `read_user_basic_info` permission.
 */
+ (LUAPIRequest *)requestForCurrentUser;

/**
 Builds a request to fetch the user with the given user ID.

 On success, this request will return an `LUUser` instance.

 @param userID The ID for the user requested.
 @deprecated This method has been deprecated. Use `requestForCurrentUser` instead.
 */
+ (LUAPIRequest *)requestForUserWithID:(NSNumber *)userID __deprecated;

/**
 Builds a request to create a user.

 On success, this request will return the newly created `LUUser`.

 @warning Use of this request requires an Enterprise SDK license.
 @param user The `LUUser` to create.
 */
+ (LUAPIRequest *)requestToCreateUser:(LUUser *)user;

/**
 Builds a request to reset the password of a user.

 On success, this request will return `nil`.

 @warning Use of this request requires an Enterprise SDK license.
 @param email An email address.
 */
+ (LUAPIRequest *)requestToResetPasswordWithEmail:(NSString *)email;

/**
 Builds a request to update a user.

 On success, this request will return the updated `LUUser`.

 @warning Use of this request requires an Enterprise SDK license.
 @param user The `LUUser` to update.
 */
+ (LUAPIRequest *)requestToUpdateUser:(LUUser *)user;

@end
