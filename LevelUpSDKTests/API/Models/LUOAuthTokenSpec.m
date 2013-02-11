#import "LUOAuthToken.h"

SPEC_BEGIN(LUOAuthTokenSpec)

describe(@"LUOAuthToken", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUAPIModel class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
