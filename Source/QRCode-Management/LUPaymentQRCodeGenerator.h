// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import <UIKit/UIKit.h>
#import "LUPaymentToken.h"

/**
 `LUPaymentQRCodeGenerator` is used to build QR codes for users' payment tokens. All LevelUp QR codes
 include a unique identifier for the current user, but may optionally include a tip percentage or
 the ID of a color that the user would like the LevelUp docks to glow.

 ## Glow Colors

 The current table of colors is:

 - 0: #00FF00 "Soothing Green"
 - 1: #BAFF48 "Atomic Lime"
 - 2: #FF0002 "Tango Red"
 - 3: #0030F8 "Galactic Blue"
 - 4: #7800F7 "Purple Haze"
 - 5: #FFFC48 "Yellow Submarine"
 - 6: #00E4FD "Arctic Teal"
 - 7: #FF00C6 "Sick Flamingo"
 - 8: #00FF84 "Mint Julep"
 - 9: #FF721C "Ninja Orange"
 */
@interface LUPaymentQRCodeGenerator : NSObject

/**
 Generates a `UIImage` containing a QR code with a payment token.

 @param paymentToken The payment token to use when generating the QR code.

 @return A `UIImage` containing the QR code.
 */
+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken;

/**
 Generates a `UIImage` containing a QR code with a payment token and a tip percentage.

 @param paymentToken The payment token to use when generating the QR code.
 @param tipPercentage A tip percentage as a number from 0 to 100.

 @return A `UIImage` containing the QR code.
 */
+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken withTipPercentage:(NSInteger)tipPercentage;

/**
 Generates a `UIImage` containing a QR code with a payment token, tip percentage and glow color ID.

 @param paymentToken The payment token to use when generating the QR code.
 @param tipPercentage A tip percentage as a number from 0 to 100.
 @param glowColorID The ID of a color.

 @return A `UIImage` containing the QR code.
 */
+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken withTipPercentage:(NSInteger)tipPercentage glowColorID:(NSInteger)glowColorID;

@end