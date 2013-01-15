#import "LUCauseCategory.h"

SPEC_BEGIN(LUCauseCategorySpec)

describe(@"LUCauseCategory", ^{
  it(@"should be an LUAPIModel", ^{
    [[[LUCauseCategory class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
