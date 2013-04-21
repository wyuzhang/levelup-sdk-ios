#import "LUOAuthToken.h"
#import "LUOAuthTokenJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUOAuthTokenJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *accessToken = [attributes stringForKey:@"access_token"];
  NSNumber *xUserID = [attributes numberForKey:@"x_user_id"];

  return [[LUOAuthToken alloc] initWithAccessToken:accessToken xUserID:xUserID];
}

@end
