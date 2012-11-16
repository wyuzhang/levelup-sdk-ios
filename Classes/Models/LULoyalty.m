#import "LUJSONDeserializer.h"
#import "LULoyalty.h"
#import "LUMonetaryValue.h"

@implementation LULoyalty

#pragma mark -
#pragma mark Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"loyalty"];
  }
}

#pragma mark -
#pragma mark Properties

- (BOOL)isOnboardingEligible {
  return [self.onboardingEligible boolValue];
}

- (float)progress {
  return [self.progressPercent floatValue] * 0.01f;
}

@end
