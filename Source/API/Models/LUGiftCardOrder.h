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

#import "LUAPIModel.h"

@class LUMonetaryValue;

/**
 Representation of a gift card order. Used with `LUGiftCardRequestFactory` to create a LevelUp gift
 card.

 Gift cards can be global (they can be used at any LevelUp merchant) or can be for a specific
 merchant.
 */
@interface LUGiftCardOrder : LUAPIModel

/**
 The merchant ID for the gift card. If `nil`, the gift card can be used at any merchant.
 */
@property (nonatomic, copy, readonly) NSNumber *merchantID;

/**
 The gift card recipient's email.
 */
@property (nonatomic, copy, readonly) NSString *recipientEmail;

/**
 A message to display to the gift card recipient when they receive the gift card.
 */
@property (nonatomic, copy, readonly) NSString *recipientMessage;

/**
 The gift card recipient's name.
 */
@property (nonatomic, copy, readonly) NSString *recipientName;

/**
 The gift card's amount.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *value;

/**
 Initializer for `LUGiftCardOrder`.
 @param merchantID The merchant ID for the gift card. If `nil`, the gift card can be used at any merchant.
 @param recipientEmail The gift card recipient's email.
 @param recipientMessage A message to display to the gift card recipient when they receive the gift card.
 @param recipientName The gift card recipient's name.
 @param value The gift card's amount.
 */
- (instancetype)initWithMerchantID:(NSNumber *)merchantID
                    recipientEmail:(NSString *)recipientEmail
                  recipientMessage:(NSString *)recipientMessage
                     recipientName:(NSString *)recipientName
                             value:(LUMonetaryValue *)value;

@end
