#import "LUCategory.h"

SPEC_BEGIN(LUCategorySpec)

describe(@"LUCategory", ^{
  it(@"should be an LUAPIModel", ^{
    [[[LUCategory class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
