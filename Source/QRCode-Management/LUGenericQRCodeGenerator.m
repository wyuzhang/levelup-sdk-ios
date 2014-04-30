// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import <ZXingObjC/ZXingObjCQRCode.h>
#import "LUGenericQRCodeGenerator.h"

@implementation LUGenericQRCodeGenerator

#pragma mark - Public Methods

+ (UIImage *)QRCodeFromString:(NSString *)string {
  NSError *error = nil;
  ZXQRCodeWriter *writer = [[ZXQRCodeWriter alloc] init];
  ZXBitMatrix *result = [writer encode:string
                                format:kBarcodeFormatQRCode
                                 width:500
                                height:500
                                 error:&error];

  return [[UIImage alloc] initWithCGImage:[[ZXImage imageWithMatrix:result] cgimage]
                                    scale:1.0
                              orientation:UIImageOrientationDown];
}

@end
