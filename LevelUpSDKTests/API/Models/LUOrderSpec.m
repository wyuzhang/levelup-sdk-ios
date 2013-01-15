#import "LUOrder.h"

SPEC_BEGIN(LUOrderSpec)

describe(@"LUOrder", ^{
  it(@"should be an LUAPIModel", ^{
    [[[LUOrder class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
