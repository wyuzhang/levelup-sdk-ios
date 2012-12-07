#import "LUCampaign.h"
#import "LUInterstitialAction.h"
#import "LUJSONDeserializer.h"

#define kCustomerAcquisitionShareType @"customer_acquisition_share"
#define kEmailCaptureClaimType @"email_capture_claim"

@implementation LUInterstitialAction

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"interstitial_action"];
  }
}

#pragma mark - Public Methods

- (BOOL)isCustomerAcquisitionShare {
  return [self.type isEqualToString:kCustomerAcquisitionShareType];
}

- (BOOL)isEmailCaptureClaim {
  return [self.type isEqualToString:kEmailCaptureClaimType];
}

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.campaign) {
    total += [self.campaign hash] * 11;
  }
  if (self.type) {
    total += [self.type hash] * 13;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUInterstitialAction class]]) {
    LUInterstitialAction *otherInterstitialAction = (LUInterstitialAction *)otherObject;

    BOOL campaignEqual = ((!otherInterstitialAction.campaign && !self.campaign) ||
                       (otherInterstitialAction.campaign && self.campaign &&
                        [otherInterstitialAction.campaign isEqual:self.campaign]));

    BOOL typeEqual = ((!otherInterstitialAction.type && !self.type) ||
                       (otherInterstitialAction.type && self.type &&
                        [otherInterstitialAction.type isEqualToString:self.type]));

    return campaignEqual && typeEqual;
  }

  return NO;
}

@end
