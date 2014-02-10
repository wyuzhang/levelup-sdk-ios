// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUGenericQRCodeGenerator.h"
#import "LUPaymentQRCodeGenerator.h"
#import "LUPaymentStringGenerator.h"

@implementation LUPaymentQRCodeGenerator

#pragma mark - Public Methods

+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken {
  NSString *paymentString = [LUPaymentStringGenerator paymentStringWithToken:paymentToken tipPercentage:0 glowColorID:0];

  return [LUGenericQRCodeGenerator QRCodeFromString:paymentString];
}

+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken withTipAmountInUSCents:(NSInteger)tipAmount {
  NSString *paymentString = [LUPaymentStringGenerator paymentStringWithToken:paymentToken tipAmountInUSCents:tipAmount glowColorID:0];

  return [LUGenericQRCodeGenerator QRCodeFromString:paymentString];
}

+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken withTipAmountInUSCents:(NSInteger)tipAmount glowColorID:(NSInteger)glowColorID {
  NSString *paymentString = [LUPaymentStringGenerator paymentStringWithToken:paymentToken tipAmountInUSCents:tipAmount glowColorID:glowColorID];

  return [LUGenericQRCodeGenerator QRCodeFromString:paymentString];
}

+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken withTipPercentage:(NSInteger)tipPercentage {
  NSString *paymentString = [LUPaymentStringGenerator paymentStringWithToken:paymentToken tipPercentage:tipPercentage glowColorID:0];

  return [LUGenericQRCodeGenerator QRCodeFromString:paymentString];
}

+ (UIImage *)QRCodeFromPaymentToken:(NSString *)paymentToken withTipPercentage:(NSInteger)tipPercentage glowColorID:(NSInteger)glowColorID {
  NSString *paymentString = [LUPaymentStringGenerator paymentStringWithToken:paymentToken tipPercentage:tipPercentage glowColorID:glowColorID];

  return [LUGenericQRCodeGenerator QRCodeFromString:paymentString];
}

@end
