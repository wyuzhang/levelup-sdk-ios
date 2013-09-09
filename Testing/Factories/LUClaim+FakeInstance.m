// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUClaim+FakeInstance.h"
#import "LUMonetaryValue.h"
#import "NSArray+LUAdditions.h"

@implementation LUClaim (FakeInstance)

+ (LUClaim *)fakeInstance {
  return [self fakeInstanceForCampaignWithCode:@"code"];
}

+ (LUClaim *)fakeInstanceForCampaignWithCode:(NSString *)code {
  return [[LUClaim alloc] initWithCampaignID:@2
                                     claimID:@1
                                        code:code
                                       value:[LUMonetaryValue monetaryValueWithUSD:@5]
                              valueRemaining:[LUMonetaryValue monetaryValueWithUSD:@2]];
}

@end
