#import "LUCohort.h"

SPEC_BEGIN(LUCohortSpec)

describe(@"LUCohort", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUCohort class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
