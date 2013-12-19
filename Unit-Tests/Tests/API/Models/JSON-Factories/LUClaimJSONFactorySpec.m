// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUClaimJSONFactory.h"

SPEC_BEGIN(LUClaimJSONFactorySpec)

describe(@"LUClaimJSONFactory", ^{
  __block LUClaimJSONFactory *factory;

  beforeEach(^{
    factory = [LUClaimJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUClaim", ^{
      NSDictionary *JSON = @{
        @"code" : @"test-code",
        @"id" : @1,
        @"value_amount" : @500,
        @"value_remaining_amount" : @300
      };
      LUClaim *claim = [factory createFromAttributes:JSON];

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
