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

@end
