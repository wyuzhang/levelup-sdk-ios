// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUClaim.h"

@interface LUClaim (Fixtures)

+ (LUClaim *)fixture;
+ (LUClaim *)fixtureForCampaignWithCode:(NSString *)code;

@end
