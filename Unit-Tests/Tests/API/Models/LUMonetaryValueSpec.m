#import "LUMonetaryValue.h"

SPEC_BEGIN(LUMonetaryValueSpec)

describe(@"LUMonetaryValue", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUMonetaryValue class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Public Methods

  describe(@"monetaryValueWithUSCents:", ^{
    it(@"returns a LUMonetaryValue configured for the given amount in US Cents", ^{
      LUMonetaryValue *value = [LUMonetaryValue monetaryValueWithUSCents:@123];

      [[value.amount should] equal:@123.0f];
      [[value.currencyCode should] equal:@"USD"];
      [[value.currencySymbol should] equal:@"$"];
      [[value.formattedAmount should] equal:@"1.23"];
    });
  });

  describe(@"monetaryValueWithUSD:", ^{
    it(@"returns a LUMonetaryValue configured for the given amount in USD", ^{
      LUMonetaryValue *value = [LUMonetaryValue monetaryValueWithUSD:@1.23];

      [[value.amount should] equal:@123.0f];
      [[value.currencyCode should] equal:@"USD"];
      [[value.currencySymbol should] equal:@"$"];
      [[value.formattedAmount should] equal:@"1.23"];
    });
  });

  describe(@"formattedAmountWithSymbol", ^{
    LUMonetaryValue *monetaryValue = [LUMonetaryValue monetaryValueWithUSD:@3.5f];

    it(@"returns the currency symbol followed by the formatted amount", ^{
      [[[monetaryValue formattedAmountWithSymbol] should] equal:@"$3.50"];
    });
  });

  describe(@"shortFormatWithSymbol", ^{
    context(@"when the amount includes fractions of a dollar", ^{
      LUMonetaryValue *monetaryValue = [LUMonetaryValue monetaryValueWithUSD:@3.5f];

      it(@"returns the formattedAmountWithSymbol", ^{
        [[[monetaryValue shortFormatWithSymbol] should] equal:@"$3.50"];
      });
    });

    context(@"when the amount has only dollars (no cents)", ^{
      LUMonetaryValue *monetaryValue = [LUMonetaryValue monetaryValueWithUSD:@3.0f];

      it(@"returns the formatted amount without cents", ^{
        [[[monetaryValue shortFormatWithSymbol] should] equal:@"$3"];
      });
    });
  });
});

SPEC_END
