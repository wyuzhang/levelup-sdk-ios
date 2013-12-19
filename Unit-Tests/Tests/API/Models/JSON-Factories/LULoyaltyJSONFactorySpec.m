// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LULoyaltyJSONFactory.h"

SPEC_BEGIN(LULoyaltyJSONFactorySpec)

describe(@"LULoyaltyJSONFactory", ^{
  __block LULoyaltyJSONFactory *factory;

  beforeAll(^{
    factory = [LULoyaltyJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LULoyalty", ^{
      NSDictionary *JSON = @{
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
      LULoyalty *loyalty = [factory createFromAttributes:JSON];

      [[loyalty should] beKindOfClass:[LULoyalty class]];
      [[loyalty.willEarn should] equal:[LUMonetaryValue monetaryValueWithUSCents:@500]];
      [[loyalty.merchantID should] equal:@456];
      [[theValue(loyalty.merchantLoyaltyEnabled) should] beYes];
      [[loyalty.shouldSpend should] equal:[LUMonetaryValue monetaryValueWithUSCents:@5000]];
      [[loyalty.ordersCount should] equal:@77];
      [[loyalty.potentialCredit should] equal:[LUMonetaryValue monetaryValueWithUSCents:@7350.11]];
      [[theValue(loyalty.progressPercent) should] equal:theValue(0.42f)];
      [[loyalty.savings should] equal:[LUMonetaryValue monetaryValueWithUSCents:@835]];
      [[loyalty.spendRemaining should] equal:[LUMonetaryValue monetaryValueWithUSCents:@427]];
      [[loyalty.totalVolume should] equal:[LUMonetaryValue monetaryValueWithUSCents:@6317]];
    });
  });

  describe(@"rootKey", ^{
    it(@"returns 'loyalty'", ^{
      [[[factory rootKey] should] equal:@"loyalty"];
    });
  });
});

SPEC_END
