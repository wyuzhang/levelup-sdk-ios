// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIModel.h"

/**
 `LUAccessToken` represents an authentication token that is used for logins. It includes a token and
 the user's ID.
 */
@interface LUAccessToken : LUAPIModel

/**
 A unique access token returned by the server after authentication succeeds. In order for users to
 remain authenticated between application launches, this value should be securely stored. See
 `LUAPIClient` for more information.
 */
@property (nonatomic, copy, readonly) NSString *token;

/**
 The user's ID.
 */
@property (nonatomic, copy, readonly) NSNumber *userID;

- (id)initWithToken:(NSString *)token userID:(NSNumber *)userID;

@end
