#import "LULoyalty.h"

SPEC_BEGIN(LULoyaltySpec)

describe(@"LULoyalty", ^{
  it(@"should be an LUAPIModel", ^{
    [[[LULoyalty class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
