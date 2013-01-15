#import "LULoyalty.h"

@implementation LULoyalty

#pragma mark - Public Methods

- (BOOL)isOnboardingEligible {
  return [self.onboardingEligible boolValue];
}

- (float)progress {
  return [self.progressPercent floatValue] * 0.01f;
}

@end
