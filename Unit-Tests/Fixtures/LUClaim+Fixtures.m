#import "LUClaim+Fixtures.h"
#import "LUClaimJSONFactory.h"

@implementation LUClaim (Fixtures)

+ (LUClaim *)fullClaim {
  return [[LUClaimJSONFactory factory] fromJSONObject:[self fullJSONObject]];
}

+ (NSDictionary *)fullJSONObject {
  return @{
    @"code" : @"test-code",
    @"id" : @1,
    @"value_amount" : @500,
    @"value_remaining_amount" : @300
  };
}

@end
