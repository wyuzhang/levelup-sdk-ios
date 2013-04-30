#import "LUAPIModel.h"

/**
 The LevelUp API uses OAuth for authentication. `LUOAuthToken` represents an authentication token
 that is used for logins.
 */
@interface LUOAuthToken : LUAPIModel

/**
 A unique access token returned by the server after an OAuth token is accepted. In order for users
 to remain authenticated between application launches, this value should be securely stored. See
 `LUAPIClient` for more information.
 */
@property (nonatomic, copy, readonly) NSString *accessToken;

/**
 The user's ID.
 */
@property (nonatomic, copy, readonly) NSNumber *xUserID;

- (id)initWithAccessToken:(NSString *)accessToken xUserID:(NSNumber *)xUserID;

@end
