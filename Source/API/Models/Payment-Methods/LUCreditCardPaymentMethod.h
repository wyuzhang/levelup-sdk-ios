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

/**
 Represents a credit or debit card.
 */
@interface LUCreditCardPaymentMethod : LUAbstractPaymentMethod

/**
 `YES` if this is a debit card, else `NO`.
 */
@property (nonatomic, assign, readonly) BOOL debit;

/**
 The card's expiration month, as a number from 1 to 12.
 */
@property (nonatomic, copy) NSNumber *expirationMonth;

/**
 The card's expiration year as a four digit number (e.g. 2020).
 */
@property (nonatomic, copy) NSNumber *expirationYear;

/**
 The card's issuer, such as "MasterCard" or "Visa".
 */
@property (nonatomic, copy, readonly) NSString *issuer;

/**
 The last 4 digits of the card's number.
 */
@property (nonatomic, copy, readonly) NSString *last4Digits;

- (id)initWithDebit:(BOOL)debit expirationMonth:(NSNumber *)expirationMonth
     expirationYear:(NSNumber *)expirationYear
             issuer:(NSString *)issuer last4Digits:(NSString *)last4Digits
  monthlyBillingDay:(NSNumber *)monthlyBillingDay
monthlyTransactionLimit:(LUMonetaryValue *)monthlyTransactionLimit
paymentMethodDescription:(NSString *)paymentMethodDescription;

- (id)initWithDebit:(BOOL)debit expirationMonth:(NSNumber *)expirationMonth
     expirationYear:(NSNumber *)expirationYear
             issuer:(NSString *)issuer last4Digits:(NSString *)last4Digits
  monthlyBillingDay:(NSNumber *)monthlyBillingDay
monthlyTransactionLimit:(LUMonetaryValue *)monthlyTransactionLimit
paymentMethodDescription:(NSString *)paymentMethodDescription
paymentPreferenceType:(LUPaymentPreferenceType)paymentPreferenceType
preloadReloadThreshold:(LUMonetaryValue *)preloadReloadThreshold
       preloadValue:(LUMonetaryValue *)preloadValue;

@end
