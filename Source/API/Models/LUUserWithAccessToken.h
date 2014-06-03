// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIModel.h"

@class LUAccessToken;
@class LUUser;

/**
 `LUUserWithAccessToken` is used to store an `LUAccessToken` and an `LUUser`.
 */
@interface LUUserWithAccessToken : LUAPIModel

/**
 The access token.
 */
@property (nonatomic, strong, readonly) LUAccessToken *accessToken;

/**
 The user.
 */
@property (nonatomic, strong, readonly) LUUser *user;

- (id)initWithAccessToken:(LUAccessToken *)accessToken user:(LUUser *)user;

@end
