#import "LULegacyLoyaltyClaim.h"

SPEC_BEGIN(LULegacyLoyaltyClaimSpec)

describe(@"LULegacyLoyaltyClaim", ^{
  it(@"is an LUAPIModel", ^{
    [[[LULegacyLoyaltyClaim class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
