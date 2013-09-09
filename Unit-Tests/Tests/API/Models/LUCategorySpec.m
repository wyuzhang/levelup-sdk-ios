// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUCategory.h"

SPEC_BEGIN(LUCategorySpec)

describe(@"LUCategory", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUCategory class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
