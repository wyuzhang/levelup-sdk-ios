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

#import "LUAPIModel.h"

@class LUMonetaryValue;

/**
 An abstract class representing a payment method. All payment methods inherit from this class.
 */
@interface LUAbstractPaymentMethod : LUAPIModel

/**
 The day of the month in which the user will be billed using this payment method.

 Can be `nil` if the user is not billed monthly.
 */
@property (nonatomic, copy, readonly) NSNumber *monthlyBillingDay;

/**
 The user's transaction limit. If their pending charges reach this limit before the monthly
 billing day, the user will be charged immediately.

 Can be `nil` if the user is not billed monthly.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *monthlyTransactionLimit;

/**
 A human-readable description of this payment method.

 For example, for a credit card, this may be "Visa *1234", where "1234" are the last 4 digits of the
 card number.
 */
@property (nonatomic, copy, readonly) NSString *paymentMethodDescription;

- (id)initWithMonthlyBillingDay:(NSNumber *)monthlyBillingDay
        monthlyTransactionLimit:(LUMonetaryValue *)monthlyTransactionLimit
       paymentMethodDescription:(NSString *)paymentMethodDescription;

@end
