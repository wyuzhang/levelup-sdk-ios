#import "LUCreditCard.h"

@implementation LUCreditCard

#pragma mark - Creation

- (id)initWithBIN:(NSString *)BIN creditCardDescription:(NSString *)creditCardDescription creditCardID:(NSNumber *)creditCardID
                                cvv:(NSString *)cvv expirationMonth:(NSNumber *)expirationMonth
                     expirationYear:(NSNumber *)expirationYear last4Digits:(NSString *)last4Digits
                             number:(NSString *)number postalCode:(NSString *)postalCode promoted:(BOOL)promoted
                               type:(NSString *)type {
  self = [super init];
  if (!self) return nil;

  _BIN = BIN;
  _creditCardDescription = creditCardDescription;
  _creditCardID = creditCardID;
  _cvv = cvv;
  _expirationMonth = expirationMonth;
  _expirationYear = expirationYear;
  _last4Digits = last4Digits;
  _number = number;
  _postalCode = postalCode;
  _promoted = promoted;
  _type = type;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"LUCreditCard [creditCardDescription=%@, cvv=%@, expirationMonth=%@, expirationYear=%@, ID=%@, last4Digits=%@, number=%@, postalCode=%@, promoted=%@, type=%@]",
          self.creditCardDescription, self.cvv, self.expirationMonth, self.expirationYear, self.creditCardID,
          self.last4Digits, self.number, self.postalCode, @(self.promoted), self.type];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUCreditCard [ID=%@, last4Digits=%@, type=%@]", self.creditCardID,
          self.last4Digits, self.type];
}

@end
