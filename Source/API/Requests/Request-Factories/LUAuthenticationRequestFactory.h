// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@class LUAPIRequest;

/**
 `LUAuthenticationRequestFactory` is used to build requests to authenticate with the API.
 */
@interface LUAuthenticationRequestFactory : NSObject

/**
 Builds a request to login via an email and password.

 On success, this request will return an `LUAccessToken` instance.

 @param email The email address to use for the login.
 @param password The password to use for the login.
 */
+ (LUAPIRequest *)requestToLoginWithEmail:(NSString *)email password:(NSString *)password;

/**
 Builds a request to create a new access token with a limited set of permissions.

 On success, a new `LUAccessToken` instance will be returned.

 If the access token used for the request doesn't have access to any of the permissions, the request
 will fail with an `LUAPIErrorLoginRequired` error.

 @param permissions An array of permission names. For a full list of possible permissions, see
 http://developer.thelevelup.com/getting-started/permissions-list/
 */
+ (LUAPIRequest *)requestToCreateDowngradedAccessTokenWithPermissions:(NSArray *)permissions;

@end
