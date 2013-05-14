#import "LULoyaltyJSONFactory.h"

SPEC_BEGIN(LULoyaltyJSONFactorySpec)

describe(@"LULoyaltyJSONFactory", ^{
  __block LULoyaltyJSONFactory *factory;

  beforeEach(^{
    factory = [LULoyaltyJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LULoyalty", ^{
      LULoyalty *loyalty = [factory createFromAttributes:[LULoyalty fullJSONObject]];

      [[loyalty.loyaltyID should] equal:@1];
      [[loyalty.merchantID should] equal:@2];
      [[theValue(loyalty.merchantLoyaltyEnabled) should] beNo];
      [[loyalty.ordersCount should] equal:@100];
      [[loyalty.potentialCredit should] equal:[LUMonetaryValue fullMonetaryValue]];
      [[theValue(loyalty.progressPercent) should] equal:theValue(0.5f)];
      [[loyalty.savings should] equal:[LUMonetaryValue fullMonetaryValue]];
      [[loyalty.shouldSpend should] equal:[LUMonetaryValue fullMonetaryValue]];
      [[loyalty.spendRemaining should] equal:[LUMonetaryValue fullMonetaryValue]];
      [[loyalty.totalVolume should] equal:[LUMonetaryValue fullMonetaryValue]];
      [[loyalty.willEarn should] equal:[LUMonetaryValue fullMonetaryValue]];
    });

    context(@"when loyaltyEnabled is YES", ^{
      beforeEach(^{
        factory.loyaltyEnabled = YES;
      });

      it(@"sets merchantLoyaltyEnabled to YES", ^{
        LULoyalty *loyalty = [factory createFromAttributes:[LULoyalty fullJSONObject]];

        [[theValue(loyalty.merchantLoyaltyEnabled) should] beYes];
      });
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'loyalty'", ^{
      [[[factory rootKey] should] equal:@"loyalty"];
    });
  });
});

SPEC_END
