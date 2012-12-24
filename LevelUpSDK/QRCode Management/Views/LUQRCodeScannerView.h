#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@protocol LUQRCodeScannerViewDelegate;

@interface LUQRCodeScannerView : UIView <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (assign) UIColor *crossHairsColor;
@property (weak) id<LUQRCodeScannerViewDelegate> delegate;

- (void)clearSession;
- (void)startScanning;
- (void)stopScanning;

@end

@protocol LUQRCodeScannerViewDelegate

- (void)didDecodeQRCodeWithResult:(NSString *)result;

@end
