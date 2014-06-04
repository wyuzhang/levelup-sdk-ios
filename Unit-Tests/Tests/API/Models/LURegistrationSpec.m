#import "LURegistration.h"

SPEC_BEGIN(LURegistrationSpec)

describe(@"LURegistration", ^{
  it(@"is an LUAPIModel", ^{
    [[[LURegistration class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
