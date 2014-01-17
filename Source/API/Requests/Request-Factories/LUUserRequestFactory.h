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
 Builds a request to create a user.

 On success, this request will return the newly created `LUUser`.

 @param user The `LUUser` to create.
 */
+ (LUAPIRequest *)requestToCreateUser:(LUUser *)user;

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
