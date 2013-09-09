// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import <UIKit/UIKit.h>

/**
 `LUQRCodeGenerator` is used to build user QR codes. All LevelUp QR codes include a unique identifier for the current
 user, but may optionally include a tip percentage or the ID of a color that the user would like the LevelUp docks to
 glow.

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
@interface LUQRCodeGenerator : NSObject

/**
 The base string -- the user's QR code token.
 */
@property (nonatomic, copy) NSString *baseString;

/**
 A glow color ID.
 */
@property (nonatomic, assign) NSInteger glowColorID;

/**
 A tip percentage as a number from 0 to 100.
 */
@property (nonatomic, assign) NSInteger tipPercentage;

/**
 Generates a `UIImage` containing a QR code.

 @param QRString The base QR code string.

 @return A `UIImage` containing the QR code.
 */
+ (UIImage *)QRCodeFromString:(NSString *)QRString;

/**
 Generates a `UIImage` containing a QR code and a tip percentage.

 @param QRString The base QR code string.
 @param tipPercentage A tip percentage as a number from 0 to 100.

 @return A `UIImage` containing the QR code.
 */
+ (UIImage *)QRCodeFromString:(NSString *)QRString withTipPercentage:(NSInteger)tipPercentage;

/**
 Generates a `UIImage` containing a QR code, tip percentage and glow color ID.

 @param QRString The base QR code string.
 @param tipPercentage A tip percentage as a number from 0 to 100.
 @param glowColorID The ID of a color.

 @return A `UIImage` containing the QR code.
 */
+ (UIImage *)QRCodeFromString:(NSString *)QRString withTipPercentage:(NSInteger)tipPercentage glowColorID:(NSInteger)glowColorID;

@end
