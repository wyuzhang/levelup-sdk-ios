#import "LUBundle.h"

SPEC_BEGIN(LUBundleSpec)

describe(@"LUBundle", ^{
  it(@"should be an LUAPIModel", ^{
    [[[LUBundle class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
