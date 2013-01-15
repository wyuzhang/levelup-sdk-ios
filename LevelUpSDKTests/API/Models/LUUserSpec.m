#import "LUUser.h"

SPEC_BEGIN(LUUserSpec)

describe(@"LUUser", ^{
  it(@"should be an LUAPIModel", ^{
    [[[LUUser class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
