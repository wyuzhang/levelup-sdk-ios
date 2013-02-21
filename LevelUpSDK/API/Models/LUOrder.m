#import "LUDonation.h"
#import "LUMonetaryValue.h"
#import "LUOrder.h"
#import "NSDate+StringFormats.h"

@implementation LUOrder

#pragma mark - Public Methods

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

- (BOOL)wasRefunded {
  return (self.refundedAt != nil);
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"Order [balance=%@, closed=%@, createdAt=%@, credit=%@, donation=%@, earn=%@, ID=%@, interstitialAction=%@, location=%@, loyalty=%@, merchant=%@, refundedAt=%@, spend=%@, state=%@, tip=%@, total=%@]",
          self.balance, @(self.closed), self.createdAt, self.createdAt, self.donation, self.earn, self.orderID,
          self.interstitialAction, self.location, self.loyalty, self.merchant, self.refundedAt, self.spend, self.state,
          self.tip, self.total];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"Order [ID=%@, merchant=%@, total=%@]", self.orderID, self.merchant, self.total];
}

@end
