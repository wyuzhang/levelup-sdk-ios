#import "LULoyalty+Fixtures.h"
#import "LULoyaltyJSONFactory.h"

@implementation LULoyalty (Fixtures)

+ (NSDictionary *)fullJSONObject {
  return @{
    @"id" : @1,
    @"merchant_id" : @2,
    @"orders_count" : @100,
    @"potential_credit" : [LUMonetaryValue fullJSONObject],
    @"progress_percent" : @0.5,
    @"savings" : [LUMonetaryValue fullJSONObject],
    @"should_spend" : [LUMonetaryValue fullJSONObject],
    @"spend_remaining" : [LUMonetaryValue fullJSONObject],
    @"total_volume" : [LUMonetaryValue fullJSONObject],
    @"will_earn" : [LUMonetaryValue fullJSONObject]
  };
}

+ (LULoyalty *)fullLoyalty {
  return [[LULoyaltyJSONFactory factory] fromJSONObject:[self fullJSONObject]];
}

@end
