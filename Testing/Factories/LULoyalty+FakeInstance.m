// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LULoyalty+FakeInstance.h"
#import "LUMonetaryValue.h"

@implementation LULoyalty (FakeInstance)

+ (LULoyalty *)fakeInstance {
  return [[LULoyalty alloc] initWithMerchantID:@2
                        merchantLoyaltyEnabled:YES
                                   ordersCount:@3
                               potentialCredit:[LUMonetaryValue monetaryValueWithUSD:@500.0f]
                               progressPercent:73
                                       savings:[LUMonetaryValue monetaryValueWithUSD:@20.0f]
                                   shouldSpend:[LUMonetaryValue monetaryValueWithUSD:@100.0f]
                                spendRemaining:[LUMonetaryValue monetaryValueWithUSD:@50.0f]
                                   totalVolume:[LUMonetaryValue monetaryValueWithUSD:@100.0f]
                                      willEarn:[LUMonetaryValue monetaryValueWithUSD:@200.0f]];
}

+ (LULoyalty *)fakeInstanceWithoutMerchantLoyaltyEnabled {
  LULoyalty *loyalty = [self fakeInstance];
  [loyalty setValue:@NO forKey:@"merchantLoyaltyEnabled"];
  return loyalty;
}

@end
