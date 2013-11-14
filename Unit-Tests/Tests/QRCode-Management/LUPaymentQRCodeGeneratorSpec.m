// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUGenericQRCodeGenerator.h"
#import "LUPaymentQRCodeGenerator.h"

SPEC_BEGIN(LUPaymentQRCodeGeneratorSpec)

describe(@"LUPaymentQRCodeGenerator", ^{
  NSString *paymentToken = @"LUabc";
  UIImage *mockResult = [UIImage mock];

  describe(@"QRCodeFromPaymentToken:", ^{
    NSString *expectedQRCodeData = [paymentToken stringByAppendingString:@"020000LU"];

    it(@"generates a v2 QR code image for the payment token with tip 0 and glow color ID 0", ^{
      [[LUGenericQRCodeGenerator stubAndReturn:mockResult] QRCodeFromString:expectedQRCodeData];

      UIImage *result = [LUPaymentQRCodeGenerator QRCodeFromPaymentToken:paymentToken];

      [[result should] equal:mockResult];
    });
  });

  describe(@"QRCodeFromPaymentToken:withTipPercentage:", ^{
    NSString *expectedQRCodeData = [paymentToken stringByAppendingString:@"0200F0LU"];

    it(@"generates a v2 QR code image for the payment token with the given tip and glow color ID 0", ^{
      [[LUGenericQRCodeGenerator stubAndReturn:mockResult] QRCodeFromString:expectedQRCodeData];

      UIImage *result = [LUPaymentQRCodeGenerator QRCodeFromPaymentToken:paymentToken withTipPercentage:15];

      [[result should] equal:mockResult];
    });
  });

  describe(@"QRCodeFromPaymentToken:withTipPercentage:glowColorID:", ^{
    NSString *expectedQRCodeData = [paymentToken stringByAppendingString:@"0200FALU"];

    it(@"generates a v2 QR code image for the payment token with the given tip and glow color ID", ^{
      [[LUGenericQRCodeGenerator stubAndReturn:mockResult] QRCodeFromString:expectedQRCodeData];

      UIImage *result = [LUPaymentQRCodeGenerator QRCodeFromPaymentToken:paymentToken withTipPercentage:15 glowColorID:10];

      [[result should] equal:mockResult];
    });
  });
});

SPEC_END
