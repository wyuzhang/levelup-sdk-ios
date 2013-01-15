#import "LUCohort.h"

SPEC_BEGIN(LUCohortSpec)

describe(@"LUCohort", ^{
  it(@"should be an LUAPIModel", ^{
    [[[LUCohort class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
