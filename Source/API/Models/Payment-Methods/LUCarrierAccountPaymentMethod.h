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
 Represents a carrier account payment method for users who pay with their carrier bill.
 */
@interface LUCarrierAccountPaymentMethod : LUAbstractPaymentMethod

/**
 The carrier being billed, such as "Sprint".
 */
@property (nonatomic, copy, readonly) NSString *carrier;

/**
 The last 4 digits of the user's phone number.
 */
@property (nonatomic, copy, readonly) NSString *last4Digits;

- (id)initWithCarrier:(NSString *)carrier last4Digits:(NSString *)last4Digits
    monthlyBillingDay:(NSNumber *)monthlyBillingDay
monthlyTransactionLimit:(LUMonetaryValue *)monthlyTransactionLimit
paymentMethodDescription:(NSString *)paymentMethodDescription;

@end
