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

#import "LUCreditCardPaymentMethod+Fixtures.h"
#import "LUMonetaryValue.h"

@implementation LUCreditCardPaymentMethod (Fixtures)

+ (LUCreditCardPaymentMethod *)fixture {
  NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
  NSNumber *expirationYear = [NSNumber numberWithInteger:components.year + 2];

  return [[LUCreditCardPaymentMethod alloc] initWithDebit:NO expirationMonth:@11
                                           expirationYear:expirationYear issuer:@"Visa"
                                              last4Digits:@"1234" monthlyBillingDay:@15
                                  monthlyTransactionLimit:[LUMonetaryValue monetaryValueWithUSD:@150]
                                 paymentMethodDescription:@"Visa *1234"
                                    paymentPreferenceType:LUPaymentPreferenceTypeMonthlyBilling
                                   preloadReloadThreshold:nil
                                             preloadValue:nil];
}

+ (LUCreditCardPaymentMethod *)fixtureForDebitCard {
  LUCreditCardPaymentMethod *creditCard = [self fixture];
  [creditCard setValue:@YES forKey:@"debit"];
  return creditCard;
}

@end
