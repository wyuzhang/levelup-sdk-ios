#import "LUCampaign.h"
#import "LUInterstitialAction.h"
#import "LUJSONDeserializer.h"

#define kCustomerAcquisitionShareType @"customer_acquisition_share"
#define kEmailCaptureClaimType @"email_capture_claim"

@implementation LUInterstitialAction

#pragma mark -
#pragma mark Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"interstitial_action"];
  }
}

#pragma mark -
#pragma mark Public Methods

- (BOOL)isCustomerAcquisitionShare {
  return [self.type isEqualToString:kCustomerAcquisitionShareType];
}

- (BOOL)isEmailCaptureClaim {
  return [self.type isEqualToString:kEmailCaptureClaimType];
}

@end
