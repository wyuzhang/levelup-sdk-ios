// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

/**
 `LUAuthenticationRequestFactory` is used to build requests to authenticate with the API.
 */
@class LUAPIRequest;

@interface LUAuthenticationRequestFactory : NSObject

/**
 Builds a request to login via an email and password.

 On success, this request will return an `LUAccessToken` instance.

 @param email The email address to use for the login.
 @param password The password to use for the login.
 */
+ (LUAPIRequest *)requestToLoginWithEmail:(NSString *)email password:(NSString *)password;

@end
