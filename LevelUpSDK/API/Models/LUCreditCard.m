#import "LUCreditCard.h"

@implementation LUCreditCard

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"CreditCard [creditCardDescription=%@, cvv=%@, expirationMonth=%@, expirationYear=%@, ID=%@, last4Digits=%@, number=%@, postalCode=%@, promoted=%@, type=%@]",
          self.creditCardDescription, self.cvv, self.expirationMonth, self.expirationYear, self.creditCardID,
          self.last4Digits, self.number, self.postalCode, @(self.promoted), self.type];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"CreditCard [ID=%@, last4Digits=%@, type=%@]", self.creditCardID, self.last4Digits, self.type];
}

@end
