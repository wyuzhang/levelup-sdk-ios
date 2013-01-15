#import "LUAPIModel.h"

@interface LUOAuthToken : LUAPIModel

@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *clientId;
@property (nonatomic, copy) NSString *facebookAccessToken;
@property (nonatomic, copy) NSString *grantType;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSNumber *xUserId;

- (NSString *)deviceIdentifier;

@end
