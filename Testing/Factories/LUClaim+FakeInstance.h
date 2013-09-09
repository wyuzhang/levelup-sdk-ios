// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUClaim.h"

@interface LUClaim (FakeInstance)

+ (LUClaim *)fakeInstance;
+ (LUClaim *)fakeInstanceForCampaignWithCode:(NSString *)code;

@end
