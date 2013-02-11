#import "LUDonation.h"
#import "LUMonetaryValue.h"
#import "LUOrder.h"
#import "NSDate+StringFormats.h"

@interface LUOrder ()

@property (nonatomic, assign) BOOL bundleClosed;
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSString *refundedAt;

@end

@implementation LUOrder

#pragma mark - Public Methods

- (NSDate *)creationDate {
  return [NSDate dateFromIso8601DateTimeString:self.createdAt];
}

- (BOOL)hasDonation {
  return (self.donation.value.amount.floatValue > 0.0f);
}

- (BOOL)hasEarnedCredit {
  return (self.earn.amount.floatValue > 0.0f);
}

- (BOOL)hasNonZeroBalance {
  return (self.balance.amount.floatValue != 0.0f);
}

- (BOOL)hasTipApplied {
  return (self.tip.amount.floatValue > 0.0f);
}

- (BOOL)hasUsedCredit {
  return (self.credit.amount.floatValue > 0.0f);
}

- (BOOL)isClosed {
  return self.bundleClosed;
}

- (BOOL)wasRefunded {
  return (self.refundedAt != nil);
}

@end
