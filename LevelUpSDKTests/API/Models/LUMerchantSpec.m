#import "LUMerchant.h"

SPEC_BEGIN(LUMerchantSpec)

describe(@"LUMerchant", ^{
  it(@"should be an LUAPIModel", ^{
    [[[LUMerchant class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
