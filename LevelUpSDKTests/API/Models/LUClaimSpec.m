#import "LUClaim.h"

SPEC_BEGIN(LUClaimSpec)

describe(@"LUClaim", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUClaim class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
