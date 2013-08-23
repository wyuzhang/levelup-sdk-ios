#import "LULoyalty+Fixtures.h"
#import "LULoyaltyJSONFactory.h"

@implementation LULoyalty (Fixtures)

+ (NSDictionary *)fullJSONObject {
  return @{
    @"merchant_earn_amount" : @500,
    @"merchant_id" : @456,
    @"merchant_loyalty_enabled" : @YES,
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
  LULoyaltyJSONFactory *factory = [LULoyaltyJSONFactory factory];
  return [factory fromJSONObject:[self fullJSONObject]];
}

@end
