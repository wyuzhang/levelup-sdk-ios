// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUCreditCard.h"

SPEC_BEGIN(LUCreditCardSpec)

describe(@"LUCreditCard", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUCreditCard class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
