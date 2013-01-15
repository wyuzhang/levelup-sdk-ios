#import "LUMerchandiseOrder.h"

SPEC_BEGIN(LUMerchandiseOrderSpec)

describe(@"LUMerchandiseOrder", ^{
  it(@"should be an LUAPIModel", ^{
    [[[LUMerchandiseOrder class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
