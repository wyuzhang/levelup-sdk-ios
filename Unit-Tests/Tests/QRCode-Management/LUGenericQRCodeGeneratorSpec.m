/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "LUGenericQRCodeGenerator.h"
#import <ZXingObjC/ZXingObjCQRCode.h>

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
