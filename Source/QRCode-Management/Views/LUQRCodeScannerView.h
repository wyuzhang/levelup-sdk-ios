// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

/**
 `LUQRCodeScannerView` is a utility class to simplify the process of scanning QR codes.

 ## Usage

 Simply add an `LUQRCodeScannerView` to a view, and use the `clearSession`, `startScanning`, and `stopScanning` methods
 to control the scanner. Specify a `LUQRCodeScannerViewDelegate` to be notified when a QR code is successfully scanned.
 */
@protocol LUQRCodeScannerViewDelegate;

@interface LUQRCodeScannerView : UIView <AVCaptureVideoDataOutputSampleBufferDelegate>

/**
 The color of the cross hairs on the view. Default is #1EBBF3.
 */
@property (assign) UIColor *crossHairsColor;

/**
 A `LUQRCodeScannerViewDelegate` delegate.
 */
@property (weak) id<LUQRCodeScannerViewDelegate> delegate;

/**
 Clears the current scanning session.
 */
- (void)clearSession;

/**
 Begins scanning.
 */
- (void)startScanning;

/**
 Stops scanning.
 */
- (void)stopScanning;

@end

/**
 The `LUQRCodeScannerViewDelegate` protocol is used to be notified when an `LUQRCodeScannerView` successfully scans
 a QR code.
 */
@protocol LUQRCodeScannerViewDelegate

/**
 Called when a QR code has been scanned.

 @param result The data of the QR code.
*/
- (void)didDecodeQRCodeWithResult:(NSString *)result;

@end
