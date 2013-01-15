#import "LUCause.h"

SPEC_BEGIN(LUCauseSpec)

describe(@"LUCause", ^{
  it(@"should be an LUAPIModel", ^{
    [[[LUCause class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
