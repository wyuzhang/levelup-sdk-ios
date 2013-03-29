#import "LUCreditCard.h"

SPEC_BEGIN(LUCreditCardSpec)

describe(@"LUCreditCard", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUCreditCard class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
