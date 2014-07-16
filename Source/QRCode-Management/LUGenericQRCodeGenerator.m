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
