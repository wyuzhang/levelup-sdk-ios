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

/**
 `LUPaymentMethodRequestFactory` is used to build requests related to the user's payment method.
 */
@interface LUPaymentMethodRequestFactory : NSObject

/**
 Builds a request to retrieve the current user's payment method.

 This will return the user's primary payment method which will be used to bill the user.

 If the user has not added any payment methods, or if they don't have an active payment method, this
 request will fail with the error code `LUAPIErrorNotFound`.

 @warning This request requires an access token with the `LUPermissionManageUserPaymentMethods`
 permission.
 */
+ (LUAPIRequest *)requestForPaymentMethod;

@end
