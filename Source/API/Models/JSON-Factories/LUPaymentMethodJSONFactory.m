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
#import "LUCarrierAccountPaymentMethod.h"
#import "LUCreditCardPaymentMethod.h"
#import "LUPaymentMethodJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUPaymentMethodJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSNumber *monthlyBillingDay = [attributes lu_numberForKey:@"monthly_billing_day"];
  LUMonetaryValue *monthlyTransactionLimit = [attributes lu_monetaryValueForKey:@"monthly_transaction_limit_amount"];
  NSString *paymentMethodDescription = [attributes lu_stringForKey:@"description"];
  NSDictionary *metadata = [attributes lu_dictionaryForKey:@"metadata"];
  NSString *type = [attributes lu_stringForKey:@"type"];

  if ([type isEqualToString:@"apple_pay_card"]) {
    NSString *issuer = [metadata lu_stringForKey:@"issuer"];

    return [[LUApplePayCardPaymentMethod alloc] initWithIssuer:issuer
                                             monthlyBillingDay:monthlyBillingDay
                                       monthlyTransactionLimit:monthlyTransactionLimit
                                      paymentMethodDescription:paymentMethodDescription];
  } else if ([type isEqualToString:@"carrier"]) {
    NSString *carrier = [metadata lu_stringForKey:@"carrier"];
    NSString *last4Digits = [metadata lu_stringForKey:@"last_4"];

    return [[LUCarrierAccountPaymentMethod alloc] initWithCarrier:carrier last4Digits:last4Digits
                                                monthlyBillingDay:monthlyBillingDay
                                          monthlyTransactionLimit:monthlyTransactionLimit
                                         paymentMethodDescription:paymentMethodDescription];
  } else if ([type isEqualToString:@"credit_card"] || [type isEqualToString:@"debit_card"]) {
    BOOL debit = [type isEqualToString:@"debit_card"];
    NSNumber *expirationMonth = [metadata lu_numberForKey:@"expiration_month"];
    NSNumber *expirationYear = [metadata lu_numberForKey:@"expiration_year"];
    NSString *issuer = [metadata lu_stringForKey:@"issuer"];
    NSString *last4Digits = [metadata lu_stringForKey:@"last_4"];

    return [[LUCreditCardPaymentMethod alloc] initWithDebit:debit expirationMonth:expirationMonth
                                             expirationYear:expirationYear issuer:issuer
                                                last4Digits:last4Digits
                                          monthlyBillingDay:monthlyBillingDay
                                    monthlyTransactionLimit:monthlyTransactionLimit
                                   paymentMethodDescription:paymentMethodDescription];
  }

  return nil;
}

- (NSString *)rootKey {
  return @"payment_method";
}

@end
