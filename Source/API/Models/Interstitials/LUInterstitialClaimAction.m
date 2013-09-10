// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUInterstitialClaimAction.h"

@implementation LUInterstitialClaimAction

#pragma mark - Creation

- (id)initWithCampaignCode:(NSString *)campaignCode {
  self = [super init];
  if (!self) return nil;

  _campaignCode = campaignCode;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUInterstitialClaimAction [address=%p, campaignCode=%@]", self, self.campaignCode];
}

@end
