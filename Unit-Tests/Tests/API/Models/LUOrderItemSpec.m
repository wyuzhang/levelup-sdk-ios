// Copyright 2014 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUOrderItem.h"

SPEC_BEGIN(LUOrderItemSpec)

describe(@"LUOrderItem", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUOrderItem class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
