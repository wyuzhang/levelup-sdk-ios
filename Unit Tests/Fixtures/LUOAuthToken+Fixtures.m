#import "LUOAuthToken+Fixtures.h"

@implementation LUOAuthToken (Fixtures)

+ (NSDictionary *)fullJSONObject {
  return @{
    @"access_token" : @"access-token",
    @"x_user_id" : @1
  };
}

@end
