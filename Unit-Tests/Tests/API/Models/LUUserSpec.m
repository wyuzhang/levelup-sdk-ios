#import "LUUser.h"
#import "NSDate+StringFormats.h"

SPEC_BEGIN(LUUserSpec)

describe(@"LUUser", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUUser class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
