#import "LUBundle.h"
#import "LUMonetaryValue.h"
#import "LUOrder.h"
#import "NSDate+StringFormats.h"

@implementation LUBundle

#pragma mark - Creation Methods

- (id)initWithAmount:(LUMonetaryValue *)amount bundleID:(NSNumber *)bundleID chargeDate:(NSDate *)chargeDate
              closed:(BOOL)closed createdDate:(NSDate *)createdDate last4CreditCardDigits:(NSString *)last4CreditCardDigits
              orders:(NSArray *)orders refunds:(NSArray *)refunds totalCreditUsed:(LUMonetaryValue *)totalCreditUsed {
  self = [super init];
  if (!self) return nil;

  _amount = amount;
  _bundleID = bundleID;
  _chargeDate = chargeDate;
  _closed = closed;
  _createdDate = createdDate;
  _last4CreditCardDigits = last4CreditCardDigits;
  _orders = orders;
  _refunds = refunds;
  _totalCreditUsed = totalCreditUsed;

  return self;
}


#pragma mark - Public Methods

- (BOOL)hasChargeData {
  return (self.chargeDate != nil);
}

- (BOOL)hasNonZeroBalance {
  return (self.amount.amount.floatValue != 0.0f);
}

- (BOOL)hasSavings {
  return (self.totalCreditUsed.amount.floatValue > 0.0f);
}

- (NSArray *)ordersAndRefunds {
  NSArray *mergedOrders = [self.orders arrayByAddingObjectsFromArray:self.refunds];
  return [mergedOrders sortedArrayUsingComparator:^(id a, id b) {
    NSString *objectACreationDate = [a valueForKey:@"createdDate"];
    NSString *objectBCreationDate = [b valueForKey:@"createdDate"];

    return [objectBCreationDate compare:objectACreationDate];
  }];
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat: @"LUBundle [amount=%@, ID=%@, chargeDate=%@, closed=%@, createdDate=%@, last4CreditCardDigits=%@, orders=%@, refunds=%@, totalCreditUsed=%@]",
          self.amount, self.bundleID, self.chargeDate, @(self.closed), self.createdDate,
          self.last4CreditCardDigits, self.orders, self.refunds, self.totalCreditUsed];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUBundle [amount=%@, closed=%@, createdDate=%@, ID=%@]",
          self.amount, @(self.closed), self.createdDate, self.bundleID];
}

@end
