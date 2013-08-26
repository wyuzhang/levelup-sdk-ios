#import "LUClaimJSONFactory.h"

SPEC_BEGIN(LUClaimJSONFactorySpec)

describe(@"LUClaimJSONFactory", ^{
  __block LUClaimJSONFactory *factory;

  beforeEach(^{
    factory = [LUClaimJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUClaim", ^{
      LUClaim *claim = [factory createFromAttributes:[LUClaim fullJSONObject]];

      [[claim.code should] equal:@"test-code"];
      [[claim.claimID should] equal:@1];
      [[claim.value should] equal:[LUMonetaryValue monetaryValueWithUSCents:@500]];
      [[claim.valueRemaining should] equal:[LUMonetaryValue monetaryValueWithUSCents:@300]];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'claim'", ^{
      [[[factory rootKey] should] equal:@"claim"];
    });
  });
});

SPEC_END
