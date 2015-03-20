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

#import "LUApplePayCardPaymentMethod.h"

@implementation LUApplePayCardPaymentMethod

#pragma mark - Creation

- (id)initWithIssuer:(NSString *)issuer monthlyBillingDay:(NSNumber *)monthlyBillingDay
monthlyTransactionLimit:(LUMonetaryValue *)monthlyTransactionLimit
paymentMethodDescription:(NSString *)paymentMethodDescription {
  self = [super initWithMonthlyBillingDay:monthlyBillingDay
                  monthlyTransactionLimit:monthlyTransactionLimit
                 paymentMethodDescription:paymentMethodDescription];
  if (!self) return nil;

  _issuer = issuer;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUApplePayCardPaymentMethod [address=%p, issuer=%@, %@]",
          self, self.issuer, [super description]];
}

@end
