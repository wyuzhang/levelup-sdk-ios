#import "LUJSONDeserializer.h"
#import "LULoyalty.h"
#import "LUMonetaryValue.h"

@implementation LULoyalty

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"loyalty"];
  }
}

#pragma mark - Properties

- (BOOL)isOnboardingEligible {
  return [self.onboardingEligible boolValue];
}

- (float)progress {
  return [self.progressPercent floatValue] * 0.01f;
}

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.merchantId) {
    total += [self.merchantId intValue] * 11;
  }
  if (self.modelId) {
    total += [self.modelId intValue] * 13;
  }
  if (self.onboardingEligible) {
    total += [self.onboardingEligible intValue] * 17;
  }
  if (self.ordersCount) {
    total += [self.ordersCount intValue] * 19;
  }
  if (self.potentialCredit) {
    total += [self.potentialCredit hash] * 23;
  }
  if (self.progressPercent) {
    total += [self.progressPercent intValue] * 29;
  }
  if (self.savings) {
    total += [self.savings hash] * 31;
  }
  if (self.spendRemaining) {
    total += [self.spendRemaining hash] * 37;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LULoyalty class]]) {
    LULoyalty *otherLoyalty = (LULoyalty *)otherObject;

    BOOL merchantIdEqual = ((!otherLoyalty.merchantId && !self.merchantId) ||
        (otherLoyalty.merchantId && self.merchantId &&
        [otherLoyalty.merchantId intValue] == [self.merchantId intValue]));

    BOOL modelIdEqual = ((!otherLoyalty.modelId && !self.modelId) ||
        (otherLoyalty.modelId && self.modelId &&
        [otherLoyalty.modelId intValue] == [self.modelId intValue]));

    BOOL onboardingEligibleEqual = ((!otherLoyalty.onboardingEligible && !self.onboardingEligible) ||
        (otherLoyalty.onboardingEligible && self.onboardingEligible &&
        [otherLoyalty.onboardingEligible intValue] == [self.onboardingEligible intValue]));

    BOOL ordersCountEqual = ((!otherLoyalty.ordersCount && !self.ordersCount) ||
        (otherLoyalty.ordersCount && self.ordersCount &&
        [otherLoyalty.ordersCount intValue] == [self.ordersCount intValue]));

    BOOL potentialCreditEqual = ((!otherLoyalty.potentialCredit && !self.potentialCredit) ||
        (otherLoyalty.potentialCredit && self.potentialCredit &&
        [otherLoyalty.potentialCredit isEqual:self.potentialCredit]));

    BOOL progressPercentEqual = ((!otherLoyalty.progressPercent && !self.progressPercent) ||
        (otherLoyalty.progressPercent && self.progressPercent &&
        [otherLoyalty.progressPercent intValue] == [self.progressPercent intValue]));

    BOOL savingsEqual = ((!otherLoyalty.savings && !self.savings) ||
        (otherLoyalty.savings && self.savings &&
        [otherLoyalty.savings isEqual:self.savings]));

    BOOL spendRemainingEqual = ((!otherLoyalty.spendRemaining && !self.spendRemaining) ||
        (otherLoyalty.spendRemaining && self.spendRemaining &&
        [otherLoyalty.spendRemaining isEqual:self.spendRemaining]));

    return merchantIdEqual && modelIdEqual && onboardingEligibleEqual && ordersCountEqual &&
        potentialCreditEqual && progressPercentEqual && savingsEqual && spendRemainingEqual;
  }

  return NO;
}

@end
