#import "LUDonation.h"
#import "LUMonetaryValue.h"
#import "LUOrder.h"
#import "NSDate+StringFormats.h"

@interface LUOrder ()

@property (nonatomic, copy) NSNumber *bundleClosed;
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSString *refundedAt;

@end

@implementation LUOrder

#pragma mark - Public Methods

- (NSDate *)creationDate {
  return [NSDate dateFromIso8601DateTimeString:self.createdAt];
}

- (BOOL)hasDonation {
  return (self.donation && self.donation.value && [self.donation.value.amount floatValue] > 0.0f);
}

- (BOOL)hasEarnedCredit {
  return (self.earn && [self.earn.amount floatValue] > 0.0f);
}

- (BOOL)hasNonZeroBalance {
  return ([self.balance.amount floatValue] != 0.0f);
}

- (BOOL)hasTipApplied {
  return ([self.tip.amount floatValue] > 0.0f);
}

- (BOOL)hasUsedCredit {
  return ([self.credit.amount floatValue] > 0.0f);
}

- (BOOL)isClosed {
  return [self.bundleClosed boolValue];
}

- (NSDate *)refundDate {
  return [NSDate dateFromIso8601DateTimeString:self.refundedAt];
}

- (BOOL)wasRefunded {
  return (self.refundedAt != nil);
}

@end
