#import "LUApnDevice.h"

SPEC_BEGIN(LUApnDeviceSpec)

describe(@"LUApnDevice", ^{
  it(@"should be an LUAPIModel", ^{
    [[[LUApnDevice class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
