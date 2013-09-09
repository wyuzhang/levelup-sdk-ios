// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUPaymentToken.h"

SPEC_BEGIN(LUPaymentTokenSpec)

describe(@"LUPaymentToken", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUPaymentToken class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
