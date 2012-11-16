#import "LUQRCodeGenerator.h"
#import "NSNumber+Base36.h"
#import "ZXImage.h"
#import "ZXQRCodeWriter.h"

static NSString * const kTipTypePercent = @"0";
static NSString * const kCurrentQRCodeVersion = @"01";

@implementation LUQRCodeGenerator

#pragma mark - Public Methods

+ (UIImage *)QRCodeFromString:(NSString *)QRString {
  return [self QRCodeFromString:QRString withTipPercentage:0 glowColorID:0];
}

+ (UIImage *)QRCodeFromString:(NSString *)QRString withTipPercentage:(NSInteger)tipPercentage {
  return [self QRCodeFromString:QRString withTipPercentage:tipPercentage glowColorID:0];
}

+ (UIImage *)QRCodeFromString:(NSString *)QRString withTipPercentage:(NSInteger)tipPercentage glowColorID:(NSInteger)glowColorID {
  NSError *error = nil;
  ZXQRCodeWriter *writer = [[ZXQRCodeWriter alloc] init];
  ZXBitMatrix *result = [writer encode:[self formattedQRCodeStringWithBaseString:QRString tipPercentage:tipPercentage glowColorID:glowColorID]
                                format:kBarcodeFormatQRCode
                                 width:500
                                height:500
                                 error:&error];

  return [UIImage imageWithCGImage:[[ZXImage imageWithMatrix:result] cgimage]];
}

#pragma mark - Private Methods

+ (NSString *)formattedQRCodeStringWithBaseString:(NSString *)baseString tipPercentage:(NSInteger)tipPercentage glowColorID:(NSInteger)glowColorID {
  NSMutableString *QRCodeString = [baseString mutableCopy];

  if ([baseString rangeOfString:@"-"].location == NSNotFound) {
    [QRCodeString appendString:kCurrentQRCodeVersion];
    [QRCodeString appendString:kTipTypePercent];

    NSString *tipPercentBase36 = [[NSNumber numberWithInteger:tipPercentage] base36Value];
    if (tipPercentBase36.length < 2) {
      [QRCodeString appendFormat:@"0%@", tipPercentBase36];
    } else if (tipPercentBase36.length > 2) {
      [QRCodeString appendString:[tipPercentBase36 substringToIndex:2]];
    } else {
      [QRCodeString appendString:tipPercentBase36];
    }

    [QRCodeString appendString:[[[NSNumber numberWithInt:glowColorID] base36Value] substringToIndex:1]];
  } else {
    NSMutableString *queryString = [NSMutableString string];
    if (tipPercentage > 0) {
      [queryString appendFormat:@"-t=%d", tipPercentage];
    }

    if ([queryString length] > 0) {
      [queryString appendFormat:@"%%26"];
    } else {
      [queryString appendFormat:@"-"];
    }
    [queryString appendFormat:@"c=%i", glowColorID];

    [QRCodeString appendString:queryString];
  }
  return QRCodeString;
}

@end
