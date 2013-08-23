#import "LULoyalty.h"
#import "LULoyaltyJSONFactory.h"
#import "LUMonetaryValue.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LULoyaltyJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  LUMonetaryValue *willEarn = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"merchant_earn_amount"]];
  NSNumber *merchantID = [attributes lu_numberForKey:@"merchant_id"];
  BOOL merchantLoyaltyEnabled = [attributes lu_boolForKey:@"merchant_loyalty_enabled"];
  LUMonetaryValue *shouldSpend = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"merchant_spend_amount"]];
  NSNumber *ordersCount = [attributes lu_numberForKey:@"orders_count"];
  LUMonetaryValue *potentialCredit = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"potential_credit_amount"]];
  CGFloat progressPercent = [[attributes lu_numberForKey:@"progress_percentage"] floatValue] / 100;
  LUMonetaryValue *savings = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"savings_amount"]];
  LUMonetaryValue *spendRemaining = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"spend_remaining_amount"]];
  LUMonetaryValue *totalVolume = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"total_volume_amount"]];
  return [[LULoyalty alloc] initWithMerchantID:merchantID
                        merchantLoyaltyEnabled:merchantLoyaltyEnabled
                                   ordersCount:ordersCount
                               potentialCredit:potentialCredit
                               progressPercent:progressPercent
                                       savings:savings
                                   shouldSpend:shouldSpend
                                spendRemaining:spendRemaining
                                   totalVolume:totalVolume
                                      willEarn:willEarn];
}

- (NSString *)rootKey {
  return @"loyalty";
}

@end
