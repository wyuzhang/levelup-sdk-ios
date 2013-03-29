#import "LUQRCode.h"

SPEC_BEGIN(LUQRCodeSpec)

describe(@"LUQRCode", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUQRCode class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
