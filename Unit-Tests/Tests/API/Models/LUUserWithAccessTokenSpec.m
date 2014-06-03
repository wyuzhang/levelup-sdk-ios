#import "LUUserWithAccessToken.h"

SPEC_BEGIN(LUUserWithAccessTokenSpec)

describe(@"LUUserWithAccessToken", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUUserWithAccessToken class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
