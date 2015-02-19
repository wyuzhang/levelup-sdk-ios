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

/**
 `LUPaymentToken` is a payment token used to represent a user when they make a transaction. The
 payment token's data is presented in a QR code, which is scanned when the user pays. Each payment
 token is scoped to the app which is requesting it.

 A payment token may optionally have a message associated with it, which should be shown to the
 user. If the payment token has a message, it might also have an action, which directs the user
 to a particular screen in the app. See `LUConstants.h` for a list of possible actions.
 */
@interface LUPaymentToken : LUAPIModel

/**
 An optional action associated with this token. If a payment token has an action, it will have a
 message as well.
 */
@property (nonatomic, copy, readonly) NSString *action;

/**
 This payment token's data. Use the `LUQRCodeGenerator` class to generate QR codes from this data
 which include the user's tip selection.
*/
@property (nonatomic, copy, readonly) NSString *data;

/**
 An optional message associated with this token. The message should be displayed to the user along
 with the payment token. A token with a message may have an `action` as well, but not always.
 */
@property (nonatomic, copy, readonly) NSString *message;

/**
 The unique identifier for this payment token.
 */
@property (nonatomic, copy, readonly) NSNumber *paymentTokenID;

- (id)initWithAction:(NSString *)action data:(NSString *)data message:(NSString *)message
      paymentTokenID:(NSNumber *)paymentTokenID;

@end
