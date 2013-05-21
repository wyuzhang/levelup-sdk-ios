#import "LUQRCodeGenerator.h"
#import <ZXingObjC/ZXingObjC.h>

@interface QRCodeScanHelper : NSObject

+ (NSString *)resultFromQRCodeImage:(UIImage *)image;

@end

@implementation QRCodeScanHelper

+ (NSString *)resultFromQRCodeImage:(UIImage *)image {
  ZXCGImageLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:[image CGImage]];
  ZXHybridBinarizer *binarizer = [[ZXHybridBinarizer alloc] initWithSource:source];
  ZXBinaryBitmap *bitmap = [[ZXBinaryBitmap alloc] initWithBinarizer:binarizer];
  ZXResult *result = [[[ZXQRCodeReader alloc] init] decode:bitmap hints:nil error:nil];

  return result.text;
}

@end

SPEC_BEGIN(LUQRCodeGeneratorSpec)

describe(@"LUQRCodeGenerator", ^{
  NSString *v2BaseString = @"LUabc";

  describe(@"QRCodeFromString:", ^{
    it(@"generates a v2 QR code image with the base string with tip 0 and glow color ID 0", ^{
      UIImage *image = [LUQRCodeGenerator QRCodeFromString:v2BaseString];
      NSString *result = [QRCodeScanHelper resultFromQRCodeImage:image];

      NSString *expected = [v2BaseString stringByAppendingString:@"020000LU"];

      [[result should] equal:expected];
    });
  });

  describe(@"QRCodeFromString:withTipPercentage:", ^{
    it(@"generates a v2 QR code image with the base string, the given tip and glow color ID 0", ^{
      UIImage *image = [LUQRCodeGenerator QRCodeFromString:v2BaseString withTipPercentage:15];
      NSString *result = [QRCodeScanHelper resultFromQRCodeImage:image];

      NSString *expected = [v2BaseString stringByAppendingString:@"0200F0LU"];

      [[result should] equal:expected];
    });
  });

  describe(@"QRCodeFromString:withTipPercentage:glowColorID:", ^{
    it(@"generates a v2 QR code image with the base string, the given tip and the given glow color ID", ^{
      UIImage *image = [LUQRCodeGenerator QRCodeFromString:v2BaseString withTipPercentage:15 glowColorID:10];
      NSString *result = [QRCodeScanHelper resultFromQRCodeImage:image];

      NSString *expected = [v2BaseString stringByAppendingString:@"0200FALU"];

      [[result should] equal:expected];
    });
  });
});

SPEC_END
