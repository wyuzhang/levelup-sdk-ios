#import "LUBundle.h"
#import "LUDonation.h"
#import "LUInterstitialAction.h"
#import "LUJSONDeserializer.h"
#import "LULocation.h"
#import "LULoyalty.h"
#import "LUMerchant.h"
#import "LUMonetaryValue.h"
#import "LUOrder.h"
#import "NSDate+StringFormats.h"

@interface LUOrder ()

@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSString *refundedAt;

@end

@implementation LUOrder

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"order"];
  }
}

#pragma mark - Properties

- (NSDate *)creationDate {
  return [NSDate dateFromIso8601DateTimeString:self.createdAt];
}

- (NSDate *)refundDate {
  return [NSDate dateFromIso8601DateTimeString:self.refundedAt];
}

#pragma mark - Public Methods

- (BOOL)hasDonation {
  return (self.donation && self.donation.value && [self.donation.value.amount floatValue] > 0);
}

- (BOOL)hasEarnedCredit {
  return (self.earn && [self.earn.amount floatValue] > 0);
}

- (BOOL)wasRefunded {
  return (self.refundedAt != nil);
}

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.balance) {
    total += [self.balance hash] * 11;
  }
  if (self.bundle) {
    total += [self.bundle hash] * 13;
  }
  if (self.code) {
    total += [self.code hash] * 17;
  }
  if (self.createdAt) {
    total += [self.createdAt hash] * 19;
  }
  if (self.credit) {
    total += [self.credit hash] * 23;
  }
  if (self.donation) {
    total += [self.donation hash] * 29;
  }
  if (self.earn) {
    total += [self.earn hash] * 31;
  }
  if (self.interstitialAction) {
    total += [self.interstitialAction hash] * 37;
  }
  if (self.location) {
    total += [self.location hash] * 41;
  }
  if (self.loyalty) {
    total += [self.loyalty hash] * 43;
  }
  if (self.merchant) {
    total += [self.merchant hash] * 47;
  }
  if (self.modelId) {
    total += [self.modelId intValue] * 53;
  }
  if (self.spend) {
    total += [self.spend hash] * 59;
  }
  if (self.state) {
    total += [self.state hash] * 61;
  }
  if (self.tip) {
    total += [self.tip hash] * 67;
  }
  if (self.total) {
    total += [self.total hash] * 71;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUOrder class]]) {
    LUOrder *otherOrder = (LUOrder *)otherObject;

    BOOL balanceEqual = ((!otherOrder.balance && !self.balance) ||
        (otherOrder.balance && self.balance &&
        [otherOrder.balance isEqual:self.balance]));

    BOOL bundleEqual = ((!otherOrder.bundle && !self.bundle) ||
        (otherOrder.bundle && self.bundle &&
        [otherOrder.bundle isEqual:self.bundle]));

    BOOL codeEqual = ((!otherOrder.code && !self.code) ||
        (otherOrder.code && self.code &&
        [otherOrder.code isEqualToString:self.code]));

    BOOL createdAtEqual = ((!otherOrder.createdAt && !self.createdAt) ||
        (otherOrder.createdAt && self.createdAt &&
        [otherOrder.createdAt isEqualToString:self.createdAt]));

    BOOL creditEqual = ((!otherOrder.credit && !self.credit) ||
        (otherOrder.credit && self.credit &&
        [otherOrder.credit isEqual:self.credit]));

    BOOL donationEqual = ((!otherOrder.donation && !self.donation) ||
        (otherOrder.donation && self.donation &&
        [otherOrder.donation isEqual:self.donation]));

    BOOL earnEqual = ((!otherOrder.earn && !self.earn) ||
        (otherOrder.earn && self.earn &&
        [otherOrder.earn isEqual:self.earn]));

    BOOL interstitialActionEqual = ((!otherOrder.interstitialAction && !self.interstitialAction) ||
        (otherOrder.interstitialAction && self.interstitialAction &&
        [otherOrder.interstitialAction isEqual:self.interstitialAction]));

    BOOL locationEqual = ((!otherOrder.location && !self.location) ||
        (otherOrder.location && self.location &&
        [otherOrder.location isEqual:self.location]));

    BOOL loyaltyEqual = ((!otherOrder.loyalty && !self.loyalty) ||
        (otherOrder.loyalty && self.loyalty &&
        [otherOrder.loyalty isEqual:self.loyalty]));

    BOOL merchantEqual = ((!otherOrder.merchant && !self.merchant) ||
        (otherOrder.merchant && self.merchant &&
        [otherOrder.merchant isEqual:self.merchant]));

    BOOL modelIdEqual = ((!otherOrder.modelId && !self.modelId) ||
        (otherOrder.modelId && self.modelId &&
        [otherOrder.modelId intValue] == [self.modelId intValue]));

    BOOL spendEqual = ((!otherOrder.spend && !self.spend) ||
        (otherOrder.spend && self.spend &&
        [otherOrder.spend isEqual:self.spend]));

    BOOL stateEqual = ((!otherOrder.state && !self.state) ||
        (otherOrder.state && self.state &&
        [otherOrder.state isEqualToString:self.state]));

    BOOL tipEqual = ((!otherOrder.tip && !self.tip) ||
        (otherOrder.tip && self.tip &&
        [otherOrder.tip isEqual:self.tip]));

    BOOL totalEqual = ((!otherOrder.total && !self.total) ||
        (otherOrder.total && self.total &&
        [otherOrder.total isEqual:self.total]));

    return balanceEqual && bundleEqual && codeEqual && createdAtEqual &&
        creditEqual && donationEqual && earnEqual && interstitialActionEqual &&
        locationEqual && loyaltyEqual && merchantEqual && modelIdEqual &&
        spendEqual && stateEqual && tipEqual && totalEqual;
  }

  return NO;
}

@end
