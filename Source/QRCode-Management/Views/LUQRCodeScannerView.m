#import "LUQRCodeDecoder.h"
#import "LUQRCodeScannerView.h"
#import "LUQROverlayView.h"

static NSInteger const kFramesPerCapture = 2;

@interface LUQRCodeScannerView ()

@property (nonatomic, assign) NSInteger captureCount;
@property (nonatomic, strong) AVCaptureDevice *captureDevice;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) CALayer *customLayer;
@property (nonatomic, strong) LUQRCodeDecoder *decoder;
@property (atomic, assign) BOOL handlingScan;
@property (nonatomic, strong) LUQROverlayView *overlayView;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation LUQRCodeScannerView

#pragma mark - Creation/Removal Methods

- (void)awakeFromNib {
  _decoder = [[LUQRCodeDecoder alloc] init];
  [self createCaptureSession];
}

#pragma mark - Public Methods

- (void)clearSession {
  self.captureDevice = nil;
  self.captureSession = nil;

  [self.customLayer removeFromSuperlayer];
  [self.previewLayer removeFromSuperlayer];
  [self.overlayView removeFromSuperview];

  self.customLayer = nil;
  self.previewLayer = nil;
  self.overlayView = nil;
}

- (void)startScanning {
  self.handlingScan = NO;
  if (![self.captureSession isRunning]) {
    [self.captureSession startRunning];
  }
}

- (void)stopScanning {
  self.handlingScan = YES;
  if ([self.captureSession isRunning]) {
    [self.captureSession stopRunning];
  }
}

#pragma mark - Properties

- (UIColor *)crossHairsColor {
  return self.overlayView.crossHairsColor;
}

- (void)setCrossHairsColor:(UIColor *)crossHairsColor {
  self.overlayView.crossHairsColor = crossHairsColor;
}

#pragma mark - Private Methods

- (void)createCaptureSession {
  // Code taken and modified from Apple QA1702.
  // Available at http://developer.apple.com/library/ios/#qa/qa1702/_index.html

  // Get the device input
  NSError *error = nil;
  AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:&error];

  if (nil == input) {
    [[[UIAlertView alloc] initWithTitle:@"Not a supported device"
                                message:@"You need a camera to run this app"
                               delegate:nil
                      cancelButtonTitle:@"Darn"
                      otherButtonTitles:nil] show];
  } else {
    // Configure output
    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    videoOutput.alwaysDiscardsLateVideoFrames = YES;
    dispatch_queue_t queue = dispatch_queue_create("cameraQueue", NULL);
    [videoOutput setSampleBufferDelegate:self queue:queue];
    dispatch_release(queue);

    // Specify the pixel format
    videoOutput.videoSettings = @{(id)kCVPixelBufferPixelFormatTypeKey: @(kCVPixelFormatType_32BGRA)};

    // Start the session running to start the flow of data
    self.captureSession = [[AVCaptureSession alloc] init];
    self.captureSession.sessionPreset = AVCaptureSessionPresetMedium;
    [self.captureSession addInput:input];
    [self.captureSession addOutput:videoOutput];

    // Add the custom layer
    self.customLayer = [CALayer layer];
    self.customLayer.frame = self.bounds;
    self.customLayer.transform = CATransform3DRotate(CATransform3DIdentity, M_PI/2.0, 0, 0, 1);
    self.customLayer.contentsGravity = kCAGravityResizeAspectFill;
    [self.layer addSublayer:self.customLayer];

    // Add the preview layer
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    self.previewLayer.frame = self.customLayer.bounds;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.layer addSublayer:self.previewLayer];

    self.overlayView = [[LUQROverlayView alloc] initWithFrame:self.frame];
    self.overlayView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    [self addSubview:self.overlayView];

    self.captureCount = 0;
  }
}

#pragma mark - NSObject (AVCaptureVideoDataOutputSampleBufferDelegate) Methods

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection {
  self.captureCount++;

  if (self.captureCount > kFramesPerCapture && !self.handlingScan) {
    self.captureCount = 0;

    [self.decoder decodeQRCodeFromSampleBuffer:sampleBuffer withCompletionHandler:^(NSString *result){
      if (!self.handlingScan) {
        [self.delegate didDecodeQRCodeWithResult:result];
      }
    }];
  }
}

#pragma mark - Properties

- (AVCaptureDevice *)captureDevice {
  return [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
}

@end
