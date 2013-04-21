#import "LULoyalty+FakeInstance.h"

@implementation LULoyalty (FakeInstance)

+ (LULoyalty *)fakeInstance {
  return [[LULoyalty alloc] initWithLoyaltyID:@1
                                   merchantID:@2
                                  ordersCount:@3
                              potentialCredit:[LUMonetaryValue monetaryValueWithUSD:@500.0f]
                              progressPercent:73
                                      savings:[LUMonetaryValue monetaryValueWithUSD:@20.0f]
                                  shouldSpend:[LUMonetaryValue monetaryValueWithUSD:@100.0f]
                               spendRemaining:[LUMonetaryValue monetaryValueWithUSD:@50.0f]
                                  totalVolume:[LUMonetaryValue monetaryValueWithUSD:@100.0f]
                                     willEarn:[LUMonetaryValue monetaryValueWithUSD:@200.0f]];
}

@end
