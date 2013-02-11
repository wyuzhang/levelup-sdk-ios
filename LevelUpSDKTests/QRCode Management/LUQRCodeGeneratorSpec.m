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
  NSString *v0BaseString = @"123-abc";
  NSString *v2BaseString = @"LUabc";

  describe(@"QRCodeFromString:", ^{
    context(@"for a version 0 code", ^{
      it(@"generate a v0 QR code image with the base string with tip 0 and glow color ID 0", ^{
        UIImage *image = [LUQRCodeGenerator QRCodeFromString:v0BaseString];
        NSString *result = [QRCodeScanHelper resultFromQRCodeImage:image];

        NSString *expected = [v0BaseString stringByAppendingString:@"-t=0%26c=0"];

        [[result should] equal:expected];
      });
    });

    context(@"for a version 2 code", ^{
      it(@"generate a v2 QR code image with the base string with tip 0 and glow color ID 0", ^{
        UIImage *image = [LUQRCodeGenerator QRCodeFromString:v2BaseString];
        NSString *result = [QRCodeScanHelper resultFromQRCodeImage:image];

        NSString *expected = [v2BaseString stringByAppendingString:@"020000LU"];

        [[result should] equal:expected];
      });
    });
  });

  describe(@"QRCodeFromString:withTipPercentage:", ^{
    context(@"for a version 0 code", ^{
      it(@"generate a v0 QR code image with the base string, the given tip and glow color ID 0", ^{
        UIImage *image = [LUQRCodeGenerator QRCodeFromString:v0BaseString withTipPercentage:15];
        NSString *result = [QRCodeScanHelper resultFromQRCodeImage:image];

        NSString *expected = [v0BaseString stringByAppendingString:@"-t=15%26c=0"];

        [[result should] equal:expected];
      });
    });

    context(@"for a version 2 code", ^{
      it(@"generate a v2 QR code image with the base string, the given tip and glow color ID 0", ^{
        UIImage *image = [LUQRCodeGenerator QRCodeFromString:v2BaseString withTipPercentage:15];
        NSString *result = [QRCodeScanHelper resultFromQRCodeImage:image];

        NSString *expected = [v2BaseString stringByAppendingString:@"0200F0LU"];

        [[result should] equal:expected];
      });
    });
  });

  describe(@"QRCodeFromString:withTipPercentage:glowColorID:", ^{
    context(@"for a version 0 code", ^{
      it(@"generate a v0 QR code image with the base string, the given tip and the given glow color ID", ^{
        UIImage *image = [LUQRCodeGenerator QRCodeFromString:v0BaseString withTipPercentage:15 glowColorID:10];
        NSString *result = [QRCodeScanHelper resultFromQRCodeImage:image];

        NSString *expected = [v0BaseString stringByAppendingString:@"-t=15%26c=10"];

        [[result should] equal:expected];
      });
    });

    context(@"for a version 2 code", ^{
      it(@"generate a v2 QR code image with the base string, the given tip and the given glow color ID", ^{
        UIImage *image = [LUQRCodeGenerator QRCodeFromString:v2BaseString withTipPercentage:15 glowColorID:10];
        NSString *result = [QRCodeScanHelper resultFromQRCodeImage:image];

        NSString *expected = [v2BaseString stringByAppendingString:@"0200FALU"];

        [[result should] equal:expected];
      });
    });
  });
});

SPEC_END
