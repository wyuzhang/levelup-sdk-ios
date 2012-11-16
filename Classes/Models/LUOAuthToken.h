#import <Foundation/Foundation.h>

@interface LUOAuthToken : NSObject

@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *clientId;
@property (nonatomic, copy, readonly) NSString *deviceIdentifier;
@property (nonatomic, copy) NSString *facebookAccessToken;
@property (nonatomic, copy) NSString *grantType;
@property (nonatomic, copy) NSNumber *modelId;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSNumber *xUserId;

- (NSDictionary *)parameters;

@end
