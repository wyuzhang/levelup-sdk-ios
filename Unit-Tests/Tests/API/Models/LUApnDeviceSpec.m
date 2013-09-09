// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUApnDevice.h"

SPEC_BEGIN(LUApnDeviceSpec)

describe(@"LUApnDevice", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUApnDevice class] should] beSubclassOfClass:[LUAPIModel class]];
  });
});

SPEC_END
