#import "LUMonetaryValue.h"

@implementation LUMonetaryValue

#pragma mark - Public Methods

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

+ (LUMonetaryValue *)valueOrDefaultFor:(LUMonetaryValue *)value {
  LUMonetaryValue *finalValue;

  if (nil == value) {
    finalValue = [[LUMonetaryValue alloc] init];
    finalValue.amount = @0;
    finalValue.currencyCode = @"USD";
    finalValue.currencySymbol = @"$";
    finalValue.formattedAmount = @"0.00";
  } else {
    finalValue = value;
  }

  return finalValue;
}

@end
