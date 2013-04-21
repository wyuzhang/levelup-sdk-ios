#import "LUMonetaryValue.h"

@implementation LUMonetaryValue

#pragma mark - Creation

- (id)initWithAmount:(NSNumber *)amount currencyCode:(NSString *)currencyCode
      currencySymbol:(NSString *)currencySymbol formattedAmount:(NSString *)formattedAmount {
  self = [super init];
  if (!self) return nil;

  _amount = amount;
  _currencyCode = currencyCode;
  _currencySymbol = currencySymbol;
  _formattedAmount = formattedAmount;

  return self;
}

#pragma mark - Public Methods

+ (LUMonetaryValue *)monetaryValueWithUSD:(NSNumber *)amount {
  return [[LUMonetaryValue alloc] initWithAmount:@(amount.floatValue * 100.0f)
                                    currencyCode:@"USD"
                                  currencySymbol:@"$"
                                 formattedAmount:[NSString stringWithFormat:@"%.2f", amount.floatValue]];
}

- (NSString *)formattedAmountWithSymbol {
  return [self.currencySymbol stringByAppendingString:self.formattedAmount];
}

- (NSString *)shortFormatWithSymbol {
  NSString *formattedAmountWithSymbol = [self formattedAmountWithSymbol];

  if([formattedAmountWithSymbol hasSuffix:@".00"]) {
    return [formattedAmountWithSymbol substringToIndex:[formattedAmountWithSymbol length] - 3];
  } else {
    return formattedAmountWithSymbol;
  }
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:@"LUMonetaryValue [amount=%@, currencyCode=%@, currencySymbol=%@, formattedAmount=%@]",
          self.amount, self.currencyCode, self.currencySymbol, self.formattedAmount];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUMonetaryValue [%@]", [self formattedAmountWithSymbol]];
}

@end
