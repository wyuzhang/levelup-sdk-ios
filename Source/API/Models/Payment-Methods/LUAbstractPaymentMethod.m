/*
 * Copyright (C) 2015 SCVNGR, Inc. d/b/a LevelUp
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

#import "LUAbstractPaymentMethod.h"
#import "LUPaymentPreferenceTypeTransformer.h"

@implementation LUAbstractPaymentMethod

+ (void)load {
  [NSValueTransformer setValueTransformer:[[LUPaymentPreferenceTypeTransformer alloc] init] forName:LUPaymentPreferenceTypeTransformerName];
}

+ (LUPaymentPreferenceType)paymentPreferenceTypeForString:(NSString *)string {
  NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:LUPaymentPreferenceTypeTransformerName];
  return [[transformer reverseTransformedValue:string] integerValue];
}

+ (NSString *)stringForPaymentPreferenceType:(LUPaymentPreferenceType)paymentPreferenceType {
  NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:LUPaymentPreferenceTypeTransformerName];
  return [transformer transformedValue:@(paymentPreferenceType)];
}

#pragma mark - Creation

- (id)initWithMonthlyBillingDay:(NSNumber *)monthlyBillingDay
        monthlyTransactionLimit:(LUMonetaryValue *)monthlyTransactionLimit
       paymentMethodDescription:(NSString *)paymentMethodDescription {
  self = [super init];
  if (!self) return nil;

  _monthlyBillingDay = monthlyBillingDay;
  _monthlyTransactionLimit = monthlyTransactionLimit;
  _paymentMethodDescription = paymentMethodDescription;

  return self;
}

- (id)initWithMonthlyBillingDay:(NSNumber *)monthlyBillingDay
        monthlyTransactionLimit:(LUMonetaryValue *)monthlyTransactionLimit
       paymentMethodDescription:(NSString *)paymentMethodDescription
          paymentPreferenceType:(LUPaymentPreferenceType)paymentPreferenceType
         preloadReloadThreshold:(LUMonetaryValue *)preloadReloadThreshold
                   preloadValue:(LUMonetaryValue *)preloadValue {
  self = [self initWithMonthlyBillingDay:monthlyBillingDay
                 monthlyTransactionLimit:monthlyTransactionLimit
                paymentMethodDescription:paymentMethodDescription];
  if (!self) return nil;

  _paymentPreferenceType = paymentPreferenceType;
  _preloadReloadThreshold = preloadReloadThreshold;
  _preloadValue = preloadValue;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"monthlyBillingDay=%@, monthlyTransactionLimit=%@, paymentMethodDescription=%@, paymentPreferenceType=%@, preloadReloadThreshold=%@, preloadValue=%@]",
          self.monthlyBillingDay, self.monthlyTransactionLimit, self.paymentMethodDescription, [LUAbstractPaymentMethod stringForPaymentPreferenceType:self.paymentPreferenceType],
          self.preloadReloadThreshold, self.preloadValue];
}

@end
