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

#import "LUCreditCardPaymentMethod.h"

@implementation LUCreditCardPaymentMethod

#pragma mark - Creation

- (id)initWithDebit:(BOOL)debit expirationMonth:(NSNumber *)expirationMonth
     expirationYear:(NSNumber *)expirationYear
             issuer:(NSString *)issuer last4Digits:(NSString *)last4Digits
  monthlyBillingDay:(NSNumber *)monthlyBillingDay
monthlyTransactionLimit:(LUMonetaryValue *)monthlyTransactionLimit
paymentMethodDescription:(NSString *)paymentMethodDescription {
  self = [super initWithMonthlyBillingDay:monthlyBillingDay
                  monthlyTransactionLimit:monthlyTransactionLimit
                 paymentMethodDescription:paymentMethodDescription];
  if (!self) return nil;

  _debit = debit;
  _expirationMonth = expirationMonth;
  _expirationYear = expirationYear;
  _issuer = issuer;
  _last4Digits = last4Digits;

  return self;
}

- (id)initWithDebit:(BOOL)debit expirationMonth:(NSNumber *)expirationMonth
     expirationYear:(NSNumber *)expirationYear
             issuer:(NSString *)issuer last4Digits:(NSString *)last4Digits
  monthlyBillingDay:(NSNumber *)monthlyBillingDay
monthlyTransactionLimit:(LUMonetaryValue *)monthlyTransactionLimit
paymentMethodDescription:(NSString *)paymentMethodDescription
paymentPreferenceType:(LUPaymentPreferenceType)paymentPreferenceType
preloadReloadThreshold:(LUMonetaryValue *)preloadReloadThreshold
       preloadValue:(LUMonetaryValue *)preloadValue {
  self = [super initWithMonthlyBillingDay:monthlyBillingDay
                  monthlyTransactionLimit:monthlyTransactionLimit
                 paymentMethodDescription:paymentMethodDescription
                    paymentPreferenceType:paymentPreferenceType
                   preloadReloadThreshold:preloadReloadThreshold
                             preloadValue:preloadValue];
  if (!self) return nil;

  _debit = debit;
  _expirationMonth = expirationMonth;
  _expirationYear = expirationYear;
  _issuer = issuer;
  _last4Digits = last4Digits;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUCreditCardPaymentMethod [address=%p, debit=%@, expirationMonth=%@, expirationYear=%@, issuer=%@, last4Digits=%@, %@]",
          self, @(self.debit), self.expirationMonth, self.expirationYear, self.issuer,
          self.last4Digits, [super description]];
}

@end
