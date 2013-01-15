#import "LULocation.h"

SPEC_BEGIN(LULocationSpec)

describe(@"LULocation", ^{
  it(@"should be an LULocation", ^{
    [[[LULocation class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
