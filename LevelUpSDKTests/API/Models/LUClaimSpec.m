#import "LUClaim.h"

SPEC_BEGIN(LUClaimSpec)

describe(@"LUClaim", ^{
  it(@"should be an LUAPIModel", ^{
    [[[LUClaim class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
