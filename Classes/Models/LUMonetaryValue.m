#import "LUJSONDeserializer.h"
#import "LUMonetaryValue.h"

@implementation LUMonetaryValue

#pragma mark -
#pragma mark Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class]
                    withIdentifiers:@[@"balance", @"credit", @"earn", @"onboarding", @"loyalties_savings",
                                      @"potential_credit", @"savings", @"spend", @"spend_remaining",
                                      @"tip", @"total", @"value"]];
  }
}

#pragma mark -
#pragma mark Public Methods

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

#pragma mark -
#pragma mark Properties

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

@end
