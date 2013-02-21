#import "LUOAuthToken.h"
#import "LUOAuthTokenModelBuilder.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUOAuthTokenModelBuilder

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  LUOAuthToken *oauthToken = [[LUOAuthToken alloc] init];
  oauthToken.accessToken = [attributes stringForKey:@"access_token"];
  oauthToken.xUserId = [attributes numberForKey:@"x_user_id"];

  return oauthToken;
}

@end
