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
#import "LUPaymentQRCodeGenerator.h"
#import "LUPaymentStringGenerator.h"

SPEC_BEGIN(LUPaymentQRCodeGeneratorSpec)

describe(@"LUPaymentQRCodeGenerator", ^{
  NSInteger glowColorID = 10;
  UIImage *mockResult = [UIImage mock];
  NSString *paymentToken = @"LU1111111111111";
  NSString *QRCodeData = @"qr-code-data";
  NSInteger tipAmount = 1000;
  NSInteger tipPercent = 10;

  beforeEach(^{
    [LUGenericQRCodeGenerator stub:@selector(QRCodeFromString:) andReturn:mockResult withArguments:QRCodeData, nil];
  });

  describe(@"QRCodeFromPaymentToken:", ^{
    it(@"generates a QR code image for a payment string with tip 0 and glow color ID 0", ^{
      [[[LUPaymentStringGenerator should] receiveAndReturn:QRCodeData] paymentStringWithToken:paymentToken tipPercentage:0 glowColorID:0];

      UIImage *result = [LUPaymentQRCodeGenerator QRCodeFromPaymentToken:paymentToken];
      [[result should] equal:mockResult];
    });
  });

  describe(@"QRCodeFromPaymentToken:withTipAmountInUSCents:", ^{
    it(@"generates a v3 QR code image for the payment token with the given tip amount and glow color ID 0", ^{
      [[[LUPaymentStringGenerator should] receiveAndReturn:QRCodeData] paymentStringWithToken:paymentToken tipAmountInUSCents:tipAmount glowColorID:0];

      UIImage *result = [LUPaymentQRCodeGenerator QRCodeFromPaymentToken:paymentToken withTipAmountInUSCents:tipAmount];
      [[result should] equal:mockResult];
    });
  });

  describe(@"QRCodeFromPaymentToken:withTipAmountInUSCents:glowColorID:", ^{
    it(@"generates a v3 QR code image for the payment token with the given tip amount and glow color ID", ^{
      [[[LUPaymentStringGenerator should] receiveAndReturn:QRCodeData] paymentStringWithToken:paymentToken tipAmountInUSCents:tipAmount glowColorID:glowColorID];

      UIImage *result = [LUPaymentQRCodeGenerator QRCodeFromPaymentToken:paymentToken withTipAmountInUSCents:tipAmount glowColorID:glowColorID];
      [[result should] equal:mockResult];
    });
  });

  describe(@"QRCodeFromPaymentToken:withTipPercentage:", ^{
    it(@"generates a v3 QR code image for the payment token with the given tip percent and glow color ID 0", ^{
      [[[LUPaymentStringGenerator should] receiveAndReturn:QRCodeData] paymentStringWithToken:paymentToken tipPercentage:tipPercent glowColorID:0];

      UIImage *result = [LUPaymentQRCodeGenerator QRCodeFromPaymentToken:paymentToken withTipPercentage:tipPercent];
      [[result should] equal:mockResult];
    });
  });

  describe(@"QRCodeFromPaymentToken:withTipPercentage:glowColorID:", ^{
    it(@"generates a v3 QR code image for the payment token with the given tip percent and glow color ID", ^{
      [[[LUPaymentStringGenerator should] receiveAndReturn:QRCodeData] paymentStringWithToken:paymentToken tipPercentage:tipPercent glowColorID:glowColorID];

      UIImage *result = [LUPaymentQRCodeGenerator QRCodeFromPaymentToken:paymentToken withTipPercentage:tipPercent glowColorID:glowColorID];
      [[result should] equal:mockResult];
    });
  });
});

SPEC_END
