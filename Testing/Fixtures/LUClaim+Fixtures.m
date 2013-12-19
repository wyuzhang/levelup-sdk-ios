// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUClaim+Fixtures.h"
#import "LUMonetaryValue.h"

@implementation LUClaim (Fixtures)

+ (LUClaim *)fixture {
  return [self fixtureForCampaignWithCode:@"code"];
}

+ (LUClaim *)fixtureForCampaignWithCode:(NSString *)code {
  return [[LUClaim alloc] initWithCampaignID:@2
                                     claimID:@1
                                        code:code
                                       value:[LUMonetaryValue monetaryValueWithUSD:@5]
                              valueRemaining:[LUMonetaryValue monetaryValueWithUSD:@2]];
}

@end
