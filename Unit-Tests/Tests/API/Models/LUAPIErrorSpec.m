#import "LUAPIError.h"

SPEC_BEGIN(LUAPIErrorSpec)

describe(@"LUAPIError", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUAPIError class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
