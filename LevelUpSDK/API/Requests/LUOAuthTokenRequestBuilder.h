@class LUAPIRequest;

@interface LUOAuthTokenRequestBuilder : NSObject

+ (LUAPIRequest *)requestToLoginWithEmail:(NSString *)email password:(NSString *)password;
+ (LUAPIRequest *)requestToLoginWithFacebookAccessToken:(NSString *)facebookAccessToken;

@end
