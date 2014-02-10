#import "LUPaymentStringGenerator.h"

SPEC_BEGIN(LUPaymentStringGeneratorSpec)

describe(@"LUPaymentStringGenerator", ^{
  NSString *paymentToken = @"LU1111111111111";

  describe(@"paymentStringWithToken:tipAmountInUSCents:glowColorID:", ^{
    it(@"returns a correct V3 payment string", ^{
      NSString *result = [LUPaymentStringGenerator paymentStringWithToken:paymentToken
                                                       tipAmountInUSCents:2000
                                                              glowColorID:10];

      [[result should] equal:[paymentToken stringByAppendingString:@"032JKALU"]];
    });

    context(@"when given a tip amount greater than the maximum amount", ^{
      it(@"returns the maximum tip amount", ^{
        NSString *result = [LUPaymentStringGenerator paymentStringWithToken:paymentToken
                                                         tipAmountInUSCents:100000
                                                                glowColorID:0];

        [[result should] equal:[paymentToken stringByAppendingString:@"03ZZZ0LU"]];
      });
    });

    context(@"when given a glow color ID greater than the highest", ^{
      it(@"returns the highest glow color ID", ^{
        NSString *result = [LUPaymentStringGenerator paymentStringWithToken:paymentToken
                                                         tipAmountInUSCents:2000
                                                                glowColorID:100];

        [[result should] equal:[paymentToken stringByAppendingString:@"032JKZLU"]];
      });
    });
  });

  describe(@"paymentStringWithToken:tipPercent:glowColorID:", ^{
    it(@"returns a correct V3 payment string", ^{
      NSString *result = [LUPaymentStringGenerator paymentStringWithToken:paymentToken
                                                            tipPercentage:15
                                                              glowColorID:10];

      [[result should] equal:[paymentToken stringByAppendingString:@"0300FALU"]];
    });

    context(@"when given a tip percentage greater than the maxmimum", ^{
      it(@"returns the maxmimum tip percentage", ^{
        NSString *result = [LUPaymentStringGenerator paymentStringWithToken:paymentToken
                                                              tipPercentage:2000
                                                                glowColorID:0];

        [[result should] equal:[paymentToken stringByAppendingString:@"030ZZ0LU"]];
      });
    });

    context(@"when given a glow color ID greater than the highest", ^{
      it(@"returns the highest glow color ID", ^{
        NSString *result = [LUPaymentStringGenerator paymentStringWithToken:paymentToken
                                                              tipPercentage:15
                                                                glowColorID:100];

        [[result should] equal:[paymentToken stringByAppendingString:@"0300FZLU"]];
      });
    });
  });
});

SPEC_END
