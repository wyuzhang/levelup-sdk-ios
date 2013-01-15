#import "LUMonetaryValue.h"

SPEC_BEGIN(LUMonetaryValueSpec)

describe(@"LUMonetaryValue", ^{
  it(@"should be an LUAPIModel", ^{
    [[[LUMonetaryValue class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
