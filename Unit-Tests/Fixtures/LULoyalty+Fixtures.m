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

+ (NSDictionary *)fullV14JSONObject {
  return @{
    @"merchant_earn_amount" : @500,
    @"merchant_id" : @456,
    @"merchant_spend_amount" : @5000,
    @"orders_count" : @77,
    @"potential_credit_amount" : @7350.11,
    @"progress_percentage" : @42.0,
    @"savings_amount" : @835,
    @"spend_remaining_amount" : @427,
    @"total_volume_amount" : @6317,
    @"user_id" : @789
  };
}

+ (LULoyalty *)fullLoyalty {
  return [[LULoyaltyJSONFactory factory] fromJSONObject:[self fullJSONObject]];
}

@end
