#import "LULoyalty.h"
#import "LULoyaltyJSONFactory.h"
#import "LUMonetaryValueJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LULoyaltyJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSNumber *loyaltyID = [attributes numberForKey:@"id"];
  NSNumber *merchantID = [attributes numberForKey:@"merchant_id"];
  NSNumber *ordersCount = [attributes numberForKey:@"orders_count"];
  LUMonetaryValue *potentialCredit = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"potential_credit"]];
  float progressPercent = [attributes floatForKey:@"progress_percent"];
  LUMonetaryValue *savings = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"savings"]];
  LUMonetaryValue *shouldSpend = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"should_spend"]];
  LUMonetaryValue *spendRemaining = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"spend_remaining"]];
  LUMonetaryValue *totalVolume = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"total_volume"]];
  LUMonetaryValue *willEarn = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"will_earn"]];

  return [[LULoyalty alloc] initWithLoyaltyID:loyaltyID merchantID:merchantID ordersCount:ordersCount
                              potentialCredit:potentialCredit progressPercent:progressPercent
                                      savings:savings shouldSpend:shouldSpend
                               spendRemaining:spendRemaining totalVolume:totalVolume willEarn:willEarn];
}

- (NSString *)rootKey {
  return @"loyalty";
}

@end
