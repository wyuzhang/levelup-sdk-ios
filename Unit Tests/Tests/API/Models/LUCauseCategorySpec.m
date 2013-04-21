#import "LUCauseCategory.h"

SPEC_BEGIN(LUCauseCategorySpec)

describe(@"LUCauseCategory", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUCauseCategory class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
