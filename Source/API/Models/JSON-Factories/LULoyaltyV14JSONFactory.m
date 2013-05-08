#import "LULoyalty.h"
#import "LULoyaltyV14JSONFactory.h"
#import "LUMonetaryValue.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LULoyaltyV14JSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  LUMonetaryValue *willEarn = [LUMonetaryValue monetaryValueWithUSCents:[attributes numberForKey:@"merchant_earn_amount"]];
  NSNumber *merchantID = [attributes numberForKey:@"merchant_id"];
  LUMonetaryValue *shouldSpend = [LUMonetaryValue monetaryValueWithUSCents:[attributes numberForKey:@"merchant_spend_amount"]];
  NSNumber *ordersCount = [attributes numberForKey:@"orders_count"];
  LUMonetaryValue *potentialCredit = [LUMonetaryValue monetaryValueWithUSCents:[attributes numberForKey:@"potential_credit_amount"]];
  CGFloat progressPercent = [[attributes numberForKey:@"progress_percentage"] floatValue] / 100;
  LUMonetaryValue *savings = [LUMonetaryValue monetaryValueWithUSCents:[attributes numberForKey:@"savings_amount"]];
  LUMonetaryValue *spendRemaining = [LUMonetaryValue monetaryValueWithUSCents:[attributes numberForKey:@"spend_remaining_amount"]];
  LUMonetaryValue *totalVolume = [LUMonetaryValue monetaryValueWithUSCents:[attributes numberForKey:@"total_volume_amount"]];
  return [[LULoyalty alloc] initWithLoyaltyID:nil
                                   merchantID:merchantID
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
