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
 For some LevelUp-powered apps, users can choose how they wish to be billed: either to preload money
 into their account (and to automatically load more money when their balance is low), or to be
 billed monthly (or in certain cases, immediately after an order is made). `LUPaymentPreference`
 is used to select a user's payment preference choice.

 See `LUPaymentPreferenceRequestFactory` to request the payment options summary and to set a user's
 payment preference.
 */
@interface LUPaymentPreference : LUAPIModel

/**
 If `YES`, the user chooses to have money preloaded into their account. If `NO`, the user will be
 charged monthly (or in certain cases, immediately after an order).
 */
@property (nonatomic, assign) BOOL preload;

/**
 If `preload` is set to `YES`, this value may be set to the amount of money to charge when money
 is loaded into their account.

 This property is optional; if it is set to `nil`, a default value will be used.
 */
@property (nonatomic, strong) LUMonetaryValue *preloadValue;

/**
 A convenience initializer for `LUPaymentPreference`.

 @param preload Whether the user chooses preloading for their account.
 */
- (id)initWithPreload:(BOOL)preload;

/**
 The designated initializer for `LUPaymentPreference`.

 @param preload Whether the user chooses preloading for their account.
 @param preloadValue The preload value if preloading has been chosen (optional).
 */
- (id)initWithPreload:(BOOL)preload preloadValue:(LUMonetaryValue *)preloadValue;

@end
