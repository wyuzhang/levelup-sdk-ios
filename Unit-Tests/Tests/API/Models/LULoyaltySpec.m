#import "LULoyalty.h"

SPEC_BEGIN(LULoyaltySpec)

describe(@"LULoyalty", ^{
  it(@"is an LUAPIModel", ^{
    [[[LULoyalty class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
