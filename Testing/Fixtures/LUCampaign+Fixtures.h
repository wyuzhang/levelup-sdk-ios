// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUCampaign.h"

@interface LUCampaign (Fixtures)

+ (LUCampaign *)fixture;
+ (LUCampaign *)fixtureForGlobalCampaign;
+ (LUCampaign *)fixtureWithCampaignID:(NSNumber *)campaignID;
+ (LUCampaign *)fixtureWithConfirmationHTML:(NSString *)confirmationHTML offerHTML:(NSString *)offerHTML;

@end
