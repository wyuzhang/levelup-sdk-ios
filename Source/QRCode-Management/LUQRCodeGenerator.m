// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import <ZXingObjC/ZXingObjC.h>
#import "LUQRCodeGenerator.h"
#import "NSNumber+Base36.h"

static NSString * const kTipTypePercent = @"0";
static NSString * const kCurrentQRCodeVersion = @"02";
static NSString * const kQRCodeSentinel = @"LU";

@implementation LUQRCodeGenerator

#pragma mark - Public Methods

+ (UIImage *)QRCodeFromString:(NSString *)QRString {
  LUQRCodeGenerator *generator = [[self alloc] initWithBaseString:QRString tipPercentage:0 glowColorID:0];

  return [generator image];
}

+ (UIImage *)QRCodeFromString:(NSString *)QRString withTipPercentage:(NSInteger)tipPercentage {
  LUQRCodeGenerator *generator = [[self alloc] initWithBaseString:QRString tipPercentage:tipPercentage glowColorID:0];

  return [generator image];
}

+ (UIImage *)QRCodeFromString:(NSString *)QRString withTipPercentage:(NSInteger)tipPercentage glowColorID:(NSInteger)glowColorID {
  LUQRCodeGenerator *generator = [[self alloc] initWithBaseString:QRString tipPercentage:tipPercentage glowColorID:glowColorID];

  return [generator image];
}

- (id)initWithBaseString:(NSString *)baseString tipPercentage:(NSInteger)tipPercentage glowColorID:(NSInteger)glowColorID {
  self = [super init];
  if (self) {
    _baseString = baseString;
    _glowColorID = glowColorID;
    _tipPercentage = tipPercentage;
  }
  return self;
}

#pragma mark - Public Methods

- (UIImage *)image {
  NSError *error = nil;
  ZXQRCodeWriter *writer = [[ZXQRCodeWriter alloc] init];
  ZXBitMatrix *result = [writer encode:[self formattedQRCodeString]
                                format:kBarcodeFormatQRCode
                                 width:500
                                height:500
                                 error:&error];

  return [[UIImage alloc] initWithCGImage:[[ZXImage imageWithMatrix:result] cgimage]
                                    scale:1.0
                              orientation:UIImageOrientationDown];
}

#pragma mark - Private

- (NSString *)formattedQRCodeString {
  NSArray *components = @[
    self.baseString,
    kCurrentQRCodeVersion,
    kTipTypePercent,
    [self tipPercentBase36],
    [self glowColorIDBase36],
    kQRCodeSentinel];

  return [components componentsJoinedByString:@""];
}
- (NSString *)glowColorIDBase36 {
  return [[[NSNumber numberWithInt:self.glowColorID] lu_base36Value] substringToIndex:1];
}

- (NSString *)tipPercentBase36 {
  NSString *tipPercentBase36 = [[NSNumber numberWithInteger:self.tipPercentage] lu_base36Value];

  if (tipPercentBase36.length < 2) {
    return [NSString stringWithFormat:@"0%@", tipPercentBase36];
  } else if (tipPercentBase36.length > 2) {
    return [tipPercentBase36 substringToIndex:2];
  } else {
    return tipPercentBase36;
  }
}

@end
