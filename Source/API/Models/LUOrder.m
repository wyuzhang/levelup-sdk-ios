#import "LUDonation.h"
#import "LUMonetaryValue.h"
#import "LUOrder.h"
#import "NSDate+StringFormats.h"

@implementation LUOrder

#pragma mark - Creation

- (id)initWithBalance:(LUMonetaryValue *)balance closed:(BOOL)closed
          createdDate:(NSDate *)createdDate credit:(LUMonetaryValue *)credit
             donation:(LUDonation *)donation earn:(LUMonetaryValue *)earn
   interstitialAction:(LUInterstitialAction *)interstitialAction location:(LULocation *)location
              loyalty:(LULoyalty *)loyalty merchant:(LUMerchant *)merchant
              orderID:(NSNumber *)orderID refundedDate:(NSDate *)refundedDate
                spend:(LUMonetaryValue *)spend state:(LUOrderState)state tip:(LUMonetaryValue *)tip
                total:(LUMonetaryValue *)total {
  self = [super init];
  if (!self) return nil;

  _balance = balance;
  _closed = closed;
  _createdDate = createdDate;
  _credit = credit;
  _donation = donation;
  _earn = earn;
  _interstitialAction = interstitialAction;
  _location = location;
  _loyalty = loyalty;
  _merchant = merchant;
  _orderID = orderID;
  _refundedDate = refundedDate;
  _spend = spend;
  _state = state;
  _tip = tip;
  _total = total;

  return self;
}

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
  return (self.refundedDate != nil);
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"LUOrder [balance=%@, closed=%@, createdDate=%@, credit=%@, donation=%@, earn=%@, ID=%@, interstitialAction=%@, location=%@, loyalty=%@, merchant=%@, refundedDate=%@, spend=%@, state=%@, tip=%@, total=%@]",
          self.balance, @(self.closed), self.createdDate, self.credit, self.donation, self.earn, self.orderID,
          self.interstitialAction, self.location, self.loyalty, self.merchant, self.refundedDate, self.spend,
          [self stateString], self.tip, self.total];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUOrder [ID=%@, merchant=%@, total=%@]", self.orderID, self.merchant, self.total];
}

#pragma mark - Private Methods

- (NSString *)stateString {
  switch (self.state) {
    case LUOrderCompleted:
      return @"completed";

    case LUOrderProcessing:
      return @"processing";

    case LUOrderRefunded:
      return @"refunded";

    default:
      return nil;
  }
}

@end
