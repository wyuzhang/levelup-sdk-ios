// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@class LUAPIRequest;

/**
 `LURegistrationRequestFactory` is used to build the request to check on a user's registration status.
 */
@interface LURegistrationRequestFactory : NSObject

/**
 Builds a request which given an email address, checks if a corresponding LevelUp user exists.

 On success, this request will return an `LURegistration` instance.

 @param email The email address to check.
 */
+ (LUAPIRequest *)requestForRegistrationWithEmail:(NSString *)email;

@end
