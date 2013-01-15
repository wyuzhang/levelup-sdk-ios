#import "LUDivision.h"

SPEC_BEGIN(LUDivisionSpec)

describe(@"LUDivision", ^{
  it(@"should be an LUAPIModel", ^{
    [[[LUDivision class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
