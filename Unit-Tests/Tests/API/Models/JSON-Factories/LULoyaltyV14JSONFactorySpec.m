#import "LULoyaltyV14JSONFactory.h"

SPEC_BEGIN(LULoyaltyV14JSONFactorySpec)

describe(@"LULoyaltyV14JSONFactory", ^{
  __block LULoyalty *loyalty;

  beforeAll(^{
    LULoyaltyV14JSONFactory *factory = [LULoyaltyV14JSONFactory factory];
    loyalty = [factory createFromAttributes:[LULoyalty fullV14JSONObject]];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an instance of LULoyalty", ^{
      [[loyalty should] beKindOfClass:[LULoyalty class]];
    });

    it(@"should set the willEarn property", ^{
      [[loyalty.willEarn should] equal:[LUMonetaryValue monetaryValueWithUSCents:@500]];
    });

    it(@"should set the merchantID property", ^{
      [[loyalty.merchantID should] equal:@456];
    });

    it(@"should set the merchantLoyaltyEnabled property", ^{
      [[theValue(loyalty.merchantLoyaltyEnabled) should] beYes];
    });

    it(@"should set the shouldSpend property", ^{
      [[loyalty.shouldSpend should] equal:[LUMonetaryValue monetaryValueWithUSCents:@5000]];
    });

    it(@"should set the ordersCount property", ^{
      [[loyalty.ordersCount should] equal:@77];
    });

    it(@"should set the potentialCredit property", ^{
      [[loyalty.potentialCredit should] equal:[LUMonetaryValue monetaryValueWithUSCents:@7350.11]];
    });

    it(@"should set the progressPercent property", ^{
      [[theValue(loyalty.progressPercent) should] equal:theValue(0.42f)];
    });

    it(@"should set the savings property", ^{
      [[loyalty.savings should] equal:[LUMonetaryValue monetaryValueWithUSCents:@835]];
    });

    it(@"should set the spendRemaining property", ^{
      [[loyalty.spendRemaining should] equal:[LUMonetaryValue monetaryValueWithUSCents:@427]];
    });

    it(@"should set the totalVolume property", ^{
      [[loyalty.totalVolume should] equal:[LUMonetaryValue monetaryValueWithUSCents:@6317]];
    });
  });

  describe(@"rootKey", ^{
    it(@"returns 'loyalty'", ^{
      LULoyaltyV14JSONFactory *factory = [LULoyaltyV14JSONFactory factory];
      [[[factory rootKey] should] equal:@"loyalty"];
    });
  });
});

SPEC_END
