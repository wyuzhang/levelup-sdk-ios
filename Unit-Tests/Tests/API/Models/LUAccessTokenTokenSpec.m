// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAccessToken.h"

SPEC_BEGIN(LUAccessTokenSpec)

describe(@"LUAccessToken", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUAccessToken class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
