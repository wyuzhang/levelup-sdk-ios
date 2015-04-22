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

@class LUAPIRequest;
@class LUPaymentPreference;

/**
 For some LevelUp-powered apps, users can choose how they wish to be billed: either to preload money
 into their account (and to automatically load more money when their balance is low), or to be
 billed monthly (or in certain cases, immediately after an order is made).

 `LUPaymentPreferenceRequestFactory` provides two requests. The first,
 `requestForPaymentOptionsSummary`, shows the options available to a user along with relevant data
 such as the day of the month they will be billed. See `LUPaymentOptionsSummary` for more
 information.

 The `requestToSetPaymentPreference:` request allows a user to choose whether or not they wish to
 preload, and the amount of money that should be loaded.
 */
@interface LUPaymentPreferenceRequestFactory : NSObject

/**
 Builds a request to retrieve a summary of payment options available to the user. If there is
 not an authenticated user, then the result will contain the options available to a newly
 registered user.

 On success, this request will return an `LUPaymentOptionsSummary` containing possible payment
 options.

 @warning If an access token is present, it must have the `LUPermissionManageUserPaymentMethods`
 permission.
 */
+ (LUAPIRequest *)requestForPaymentOptionsSummary;

/**
 Builds a request to set a user's payment preference for app to which they are authenticated.

 @warning This request requires an access token with the `LUPermissionCreateOrders` permission.
 @param paymentPreference The user's chosen payment preference.
 */
+ (LUAPIRequest *)requestToSetPaymentPreference:(LUPaymentPreference *)paymentPreference;

@end
