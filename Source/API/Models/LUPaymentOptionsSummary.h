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

extern NSString * const LUPaymentOptionInstantBilling;
extern NSString * const LUPaymentOptionMonthlyBilling;
extern NSString * const LUPaymentOptionPreload;

/**
 For some LevelUp-powered apps, users can choose how they wish to be billed: either to preload money
 into their account (and to automatically load more money when their balance is low), or to be
 billed monthly (or in certain cases, immediately after an order is made).

 `LUPaymentOptionsSummary` provides a summary of a user's possible payment options (two of
 `LUPaymentOptionInstantBilling`, `LUPaymentOptionMonthlyBilling` or `LUPaymentOptionPreload`),
 along with relevant information for a user to make their choice.

 For the monthly billing option, this model includes the maximum credit limit and monthly
 billing day that would be set if they choose that option. For the preloading, this model includes
 the amount that will be loaded into their account, and the balance threshold for reloading more
 money. Instant billing has no additional information.

 See `LUPaymentPreferenceRequestFactory` to request the payment options summary and to set a user's
 payment preference.
 */
@interface LUPaymentOptionsSummary : LUAPIModel

/**
 The maximum amount of pending charges a user can have before getting charged. Applies to the
 `LUPaymentOptionMonthlyBilling` option.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *maxCreditLimit;

/**
 The day of the month on which the user will be charged. Applies to the
 `LUPaymentOptionMonthlyBilling` option.
 */
@property (nonatomic, copy, readonly) NSNumber *monthlyBillingDay;

/**
 An array of 2 possible payment options, each one of LUPaymentOptionInstantBilling`,
 `LUPaymentOptionMonthlyBilling` or `LUPaymentOptionPreload`.
 */
@property (nonatomic, copy, readonly) NSArray *options;

/**
 Once the user's balance falls below this threshold, more money will be loaded into their account.
 Applies to the `LUPaymentOptionPreload` option.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *preloadReloadThreshold;

/**
 The amount of money loaded into a user's account when first registering or when their balance
 falls below the reload threshold.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *preloadValue;

- (id)initWithMaxCreditLimit:(LUMonetaryValue *)maxCreditLimit
           monthlyBillingDay:(NSNumber *)monthlyBillingDay options:(NSArray *)options
      preloadReloadThreshold:(LUMonetaryValue *)preloadReloadThreshold
                preloadValue:(LUMonetaryValue *)preloadValue;

@end
