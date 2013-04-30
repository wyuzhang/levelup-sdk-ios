#import "LURefund.h"
#import "NSDate+StringFormats.h"

SPEC_BEGIN(LURefundSpec)

describe(@"LURefund", ^{
  it(@"is an LUAPIModel", ^{
    [[[LURefund class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
