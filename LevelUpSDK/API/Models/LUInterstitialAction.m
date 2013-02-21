#import "LUInterstitialAction.h"

#define kCustomerAcquisitionShareType @"customer_acquisition_share"
#define kEmailCaptureClaimType @"email_capture_claim"

@implementation LUInterstitialAction

#pragma mark - Public Methods

- (BOOL)isCustomerAcquisitionShare {
  return [self.type isEqualToString:kCustomerAcquisitionShareType];
}

- (BOOL)isEmailCaptureClaim {
  return [self.type isEqualToString:kEmailCaptureClaimType];
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat: @"InterstitialAction [campaign=%@, ID=%@, type=%@]", self.campaign,
          self.interstitialActionID, self.type];
}

@end
