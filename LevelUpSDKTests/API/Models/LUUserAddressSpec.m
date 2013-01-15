#import "LUUserAddress.h"

SPEC_BEGIN(LUUserAddressSpec)

describe(@"LUUserAddress", ^{
  it(@"should be an LUAPIModel", ^{
    [[[LUUserAddress class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
