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
  return [NSString stringWithFormat:@"LUInterstitialClaimAction [campaignCode=%@]", self.campaignCode];
}

@end
