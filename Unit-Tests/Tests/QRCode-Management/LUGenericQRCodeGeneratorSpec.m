// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUGenericQRCodeGenerator.h"
#import <ZXingObjC/ZXingObjC.h>

SPEC_BEGIN(LUGenericQRCodeGeneratorSpec)

describe(@"LUGenericQRCodeGenerator", ^{
  describe(@"QRCodeFromString:", ^{
    it(@"generates a QR code image from the string", ^{
      NSString *string = @"TEST";

      UIImage *image = [LUGenericQRCodeGenerator QRCodeFromString:string];

      ZXCGImageLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:[image CGImage]];
      ZXHybridBinarizer *binarizer = [[ZXHybridBinarizer alloc] initWithSource:source];
      ZXBinaryBitmap *bitmap = [[ZXBinaryBitmap alloc] initWithBinarizer:binarizer];
      ZXResult *result = [[[ZXQRCodeReader alloc] init] decode:bitmap hints:nil error:nil];
      NSString *decodedResult = result.text;

      [[decodedResult should] equal:string];
    });
  });
});

SPEC_END
