#import "LUCauseAffiliation.h"

SPEC_BEGIN(LUCauseAffiliationSpec)

describe(@"LUCauseAffiliation", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUCauseAffiliation class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
