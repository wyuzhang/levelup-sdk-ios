/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
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
@class LUGiftCardOrder;

/**
 `LUGiftCardOrderRequestFactory` is used to create LevelUp gift cards.
 */
@interface LUGiftCardOrderRequestFactory : NSObject

/**
 Create and deliver the gift card represented in `giftCardOrder`.

 This request will charge the current user the amount in `giftCardOrder`, and emails the gift card
 to the recipient in `giftCardOrder`.

 @warning This request requires an access token with the `LUPermissionCreateOrders` permission.
 @param giftCardOrder See `LUGiftCardOrder`.
 */
+ (LUAPIRequest *)requestToCreateGiftCardOrder:(LUGiftCardOrder *)giftCardOrder;

@end
