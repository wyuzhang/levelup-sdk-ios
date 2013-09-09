// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIModel.h"

/**
 `LUPaymentToken` is a payment token used to represent a user when they make a transaction. The payment token's data
 is presented in a QR code, which is scanned when the user pays. Each payment token is scoped to the app which is
 requesting it.
 */
@interface LUPaymentToken : LUAPIModel

/**
 This payment token's data. Use the `LUQRCodeGenerator` class to generate QR codes from this data which include the
 user's tip selection.
*/
@property (nonatomic, copy, readonly) NSString *data;

/**
 The unique identifier for this payment token.
 */
@property (nonatomic, copy, readonly) NSNumber *paymentTokenID;

- (id)initWithData:(NSString *)data paymentTokenID:(NSNumber *)paymentTokenID;

@end
