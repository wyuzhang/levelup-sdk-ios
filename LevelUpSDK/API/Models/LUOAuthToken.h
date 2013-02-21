#import "LUAPIModel.h"

/**
 The LevelUp API uses OAuth for authentication. `LUOAuthToken` represents an authentication token that is used for
 logins.
 */
@interface LUOAuthToken : LUAPIModel

/**
 A unique access token returned by the server after an OAuth token is accepted. In order for users to remain
 authenticated between application launches, this value should be securely stored. See `LUAPIClient` for more
 information.
 */
@property (nonatomic, copy) NSString *accessToken;

/**
 The OAuth client ID. Must be set to the LevelUp API key.
 */
@property (nonatomic, copy) NSString *clientID;

/**
 A Facebook access token to use for authentication. The `grantType` must be set to "facebook" for this token to be used.
 */
@property (nonatomic, copy) NSString *facebookAccessToken;

/**
 Specifies the type of authentication. Currently supported are "password" if the `username` and `password` are set, or
 "facebook" if `facebookAccessToken` is set.
 */
@property (nonatomic, copy) NSString *grantType;

/**
 The password to use for authentication. The `grantType` must be set to "password" for username and password to be used.
 */
@property (nonatomic, copy) NSString *password;

/**
 The unique identifier for this category.
 */
@property (nonatomic, copy) NSNumber *oauthTokenID;

/**
 The username to use for authentication. The `grantType` must be set to "password" for username and password to be used.
 */
@property (nonatomic, copy) NSString *username;

/**
 The user's ID.
 */
@property (nonatomic, copy) NSNumber *xUserId;

@end
