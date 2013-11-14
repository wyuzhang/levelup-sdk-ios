// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import <UIKit/UIKit.h>

/**
 `LUGenericQRCodeGenerator` is used to build generic QR codes from arbitrary strings. Use
 `LUPaymentTokenQRCodeGenerator` to generate user QR codes for payment.
 */
@interface LUGenericQRCodeGenerator : NSObject

/**
 Generates a `UIImage` containing a QR code.

 @param string A string to be encoded as a QR code.

 @return A `UIImage` containing the QR code.
 */
+ (UIImage *)QRCodeFromString:(NSString *)string;

@end
