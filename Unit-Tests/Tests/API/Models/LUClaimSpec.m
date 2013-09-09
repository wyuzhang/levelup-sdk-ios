// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUClaim.h"

SPEC_BEGIN(LUClaimSpec)

describe(@"LUClaim", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUClaim class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
