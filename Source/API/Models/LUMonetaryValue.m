/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "LUMonetaryValue.h"
#import "NSNumber+LUAdditions.h"

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

+ (LUMonetaryValue *)monetaryValueByAddingValues:(NSArray *)values {
  return [[LUMonetaryValue monetaryValueWithUSCents:@0] valueByAddingValues:values];
}

+ (LUMonetaryValue *)monetaryValueWithUSCents:(NSNumber *)amount {
  return [[LUMonetaryValue alloc] initWithAmount:amount
                                    currencyCode:@"USD"
                                  currencySymbol:@"$"
                                 formattedAmount:[NSString stringWithFormat:@"%.2f", (amount.floatValue / 100)]];
}

+ (LUMonetaryValue *)monetaryValueWithUSD:(NSNumber *)amount {
  return [self monetaryValueWithUSCents:@(amount.floatValue * 100.0f)];
}

- (NSString *)formattedAmountWithSymbol {
  return [self.currencySymbol stringByAppendingString:self.formattedAmount];
}

- (NSString *)shortFormatWithSymbol {
  NSString *formattedAmountWithSymbol = [self formattedAmountWithSymbol];

  if ([formattedAmountWithSymbol hasSuffix:@".00"]) {
    return [formattedAmountWithSymbol substringToIndex:[formattedAmountWithSymbol length] - 3];
  } else {
    return formattedAmountWithSymbol;
  }
}

- (LUMonetaryValue *)valueByAddingValue:(LUMonetaryValue *)monetaryValue {
  NSDecimalNumber *amount = [self.amount lu_decimalNumber];
  NSDecimalNumber *addedAmount = [monetaryValue.amount lu_decimalNumber];

  NSDecimalNumber *sum = [amount lu_decimalNumber];
  sum = [sum decimalNumberByAdding:[addedAmount lu_decimalNumber]];

  return [LUMonetaryValue monetaryValueWithUSCents:sum];
}

- (LUMonetaryValue *)valueByAddingValues:(NSArray *)values {
  LUMonetaryValue *sum = self;
  for (LUMonetaryValue *value in values) {
    sum = [sum valueByAddingValue:value];
  }

  return sum;
}

- (LUMonetaryValue *)valueByDividingBy:(NSNumber *)divisor {
  return [LUMonetaryValue monetaryValueWithUSCents:
          [[self.amount lu_decimalNumber] decimalNumberByDividingBy:[divisor lu_decimalNumber]]];
}

- (LUMonetaryValue *)valueByMultiplyingBy:(NSNumber *)multiplier {
  return [LUMonetaryValue monetaryValueWithUSCents:
          [[self.amount lu_decimalNumber] decimalNumberByMultiplyingBy:[multiplier lu_decimalNumber]]];
}

- (LUMonetaryValue *)valueByRoundingToNearestCent {
  NSDecimalNumberHandler *roundingBehavior =
    [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                           scale:0
                                                raiseOnExactness:NO
                                                 raiseOnOverflow:NO
                                                raiseOnUnderflow:NO
                                             raiseOnDivideByZero:NO];
  return [LUMonetaryValue monetaryValueWithUSCents:
          [[self.amount lu_decimalNumber] decimalNumberByRoundingAccordingToBehavior:roundingBehavior]];
}

- (LUMonetaryValue *)valueBySubtractingValue:(LUMonetaryValue *)monetaryValue {
  NSAssert(self.amount >= monetaryValue.amount, @"LUMonetaryValue can't represent negative money values, so this "
           "method should never be called in a case where monetaryValue can possibly exceed self.amount");

  NSDecimalNumber *amount = [self.amount lu_decimalNumber];
  NSDecimalNumber *subtractedAmount = [monetaryValue.amount lu_decimalNumber];

  return [LUMonetaryValue monetaryValueWithUSCents:[amount decimalNumberBySubtracting:subtractedAmount]];
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:@"LUMonetaryValue [address=%p, amount=%@, currencyCode=%@, currencySymbol=%@, formattedAmount=%@]",
          self, self.amount, self.currencyCode, self.currencySymbol, self.formattedAmount];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUMonetaryValue [address=%p, formattedAmountWithSymbol=%@]", self, [self formattedAmountWithSymbol]];
}

@end
