#import "LULoyalty.h"
#import "LULoyaltyModelBuilder.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LULoyaltyModelBuilder

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  if (attributes[@"loyalty"]) {
    attributes = attributes[@"loyalty"];
  }

  LULoyalty *loyalty = [[LULoyalty alloc] init];
  loyalty.loyaltyID = [attributes numberForKey:@"id"];
  loyalty.merchantID = [attributes numberForKey:@"merchant_id"];
  loyalty.ordersCount = [attributes numberForKey:@"orders_count"];
  loyalty.potentialCredit = [attributes monetaryValueForKey:@"potential_credit"];
  loyalty.progressPercent = [attributes floatForKey:@"progress_percent"];
  loyalty.savings = [attributes monetaryValueForKey:@"savings"];
  loyalty.shouldSpend = [attributes monetaryValueForKey:@"should_spend"];
  loyalty.spendRemaining = [attributes monetaryValueForKey:@"spend_remaining"];
  loyalty.totalVolume = [attributes monetaryValueForKey:@"total_volume"];
  loyalty.willEarn = [attributes monetaryValueForKey:@"will_earn"];

  return loyalty;
}

@end
