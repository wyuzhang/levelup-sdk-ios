#import "LUJSONDeserializer.h"
#import "LUMonetaryValue.h"

@implementation LUMonetaryValue

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class]
                    withIdentifiers:@[@"amount", @"balance", @"credit", @"earn", @"onboarding", @"loyalties_savings",
                                      @"potential_credit", @"savings", @"spend", @"spend_remaining",
                                      @"tip", @"total", @"total_credit_used", @"value"]];
  }
}

#pragma mark - Properties

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

#pragma mark - Public Methods

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

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.amount) {
    total += [self.amount intValue] * 11;
  }
  if (self.currencyCode) {
    total += [self.currencyCode hash] * 13;
  }
  if (self.currencySymbol) {
    total += [self.currencySymbol hash] * 17;
  }
  if (self.formattedAmount) {
    total += [self.formattedAmount hash] * 19;
  }
  if (self.formattedAmountWithSymbol) {
    total += [self.formattedAmountWithSymbol hash] * 23;
  }
  if (self.modelId) {
    total += [self.modelId intValue] * 29;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUMonetaryValue class]]) {
    LUMonetaryValue *otherMonetaryValue = (LUMonetaryValue *)otherObject;

    BOOL amountEqual = ((!otherMonetaryValue.amount && !self.amount) ||
        (otherMonetaryValue.amount && self.amount &&
        [otherMonetaryValue.amount intValue] == [self.amount intValue]));

    BOOL currencyCodeEqual = ((!otherMonetaryValue.currencyCode && !self.currencyCode) ||
        (otherMonetaryValue.currencyCode && self.currencyCode &&
        [otherMonetaryValue.currencyCode isEqualToString:self.currencyCode]));

    BOOL currencySymbolEqual = ((!otherMonetaryValue.currencySymbol && !self.currencySymbol) ||
        (otherMonetaryValue.currencySymbol && self.currencySymbol &&
        [otherMonetaryValue.currencySymbol isEqualToString:self.currencySymbol]));

    BOOL formattedAmountEqual = ((!otherMonetaryValue.formattedAmount && !self.formattedAmount) ||
        (otherMonetaryValue.formattedAmount && self.formattedAmount &&
        [otherMonetaryValue.formattedAmount isEqualToString:self.formattedAmount]));

    BOOL formattedAmountWithSymbolEqual = ((!otherMonetaryValue.formattedAmountWithSymbol && !self.formattedAmountWithSymbol) ||
        (otherMonetaryValue.formattedAmountWithSymbol && self.formattedAmountWithSymbol &&
        [otherMonetaryValue.formattedAmountWithSymbol isEqualToString:self.formattedAmountWithSymbol]));

    BOOL modelIdEqual = ((!otherMonetaryValue.modelId && !self.modelId) ||
        (otherMonetaryValue.modelId && self.modelId &&
        [otherMonetaryValue.modelId intValue] == [self.modelId intValue]));

    return amountEqual && currencyCodeEqual && currencySymbolEqual && formattedAmountEqual &&
        formattedAmountWithSymbolEqual && modelIdEqual;
  }

  return NO;
}

@end
