#import "LULegacyLoyaltyClaimJSONFactory.h"

SPEC_BEGIN(LULegacyLoyaltyClaimJSONFactorySpec)

describe(@"LULegacyLoyaltyClaimJSONFactory", ^{
  __block LULegacyLoyaltyClaimJSONFactory *factory;

  beforeEach(^{
    factory = [LULegacyLoyaltyClaimJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LULegacyLoyaltyClaim", ^{
      LULegacyLoyaltyClaim *legacyLoyaltyClaim = [factory createFromAttributes:[LULegacyLoyaltyClaim fullJSONObject]];

      [[legacyLoyaltyClaim.claim should] equal:[LUClaim fullClaim]];
      [[legacyLoyaltyClaim.merchant should] equal:[LUMerchant fullMerchant]];
    });
  });
});

SPEC_END
