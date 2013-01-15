#import "LUAPIClient.h"
#import "LUOAuthToken.h"

SPEC_BEGIN(LUOAuthTokenSpec)

describe(@"LUOAuthToken", ^{
  it(@"should be an LUAPIModel", ^{
    [[[LUAPIModel class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
