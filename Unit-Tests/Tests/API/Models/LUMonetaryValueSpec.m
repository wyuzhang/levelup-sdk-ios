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

#import "LUMonetaryValue.h"

SPEC_BEGIN(LUMonetaryValueSpec)

describe(@"LUMonetaryValue", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUMonetaryValue class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Public Methods

  describe(@"monetaryValueByAddingValues:", ^{
    it(@"returns the sum of the LUMonetaryValues provided", ^{
      LUMonetaryValue *firstValue = [LUMonetaryValue monetaryValueWithUSCents:@1];
      LUMonetaryValue *secondValue = [LUMonetaryValue monetaryValueWithUSCents:@1];

      [[[LUMonetaryValue monetaryValueByAddingValues:
         @[firstValue, secondValue]] should] equal:[LUMonetaryValue monetaryValueWithUSCents:@2]];
    });
  });

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

  describe(@"valueByAddingValue:", ^{
    it(@"returns the sum of this LUMonetaryValue and the one provided", ^{
      LUMonetaryValue *firstValue = [LUMonetaryValue monetaryValueWithUSCents:@1];
      LUMonetaryValue *secondValue = [LUMonetaryValue monetaryValueWithUSCents:@1];

      [[[firstValue valueByAddingValue:secondValue] should] equal:[LUMonetaryValue monetaryValueWithUSCents:@2]];
    });
  });

  describe(@"valueByAddingValues:", ^{
    it(@"returns the sum of this LUMonetaryValue and the ones provided", ^{
      LUMonetaryValue *firstValue = [LUMonetaryValue monetaryValueWithUSCents:@1];
      LUMonetaryValue *secondValue = [LUMonetaryValue monetaryValueWithUSCents:@1];
      LUMonetaryValue *thirdValue = [LUMonetaryValue monetaryValueWithUSCents:@1];

      [[[firstValue valueByAddingValues:
         @[secondValue, thirdValue]] should] equal:[LUMonetaryValue monetaryValueWithUSCents:@3]];
    });
  });

  describe(@"valueByDividingBy:", ^{
    it(@"returns the result of dividing this LUMonetaryValue by the number provided", ^{
      LUMonetaryValue *divident = [LUMonetaryValue monetaryValueWithUSCents:@10000];
      NSNumber *divisor = @4;
      [[[divident valueByDividingBy:divisor] should] equal:[LUMonetaryValue monetaryValueWithUSCents:@2500]];
    });
  });

  describe(@"valueByMultiplyingBy:", ^{
    it(@"returns the product of this LUMonetaryValue when it is multiplied by the given number", ^{
      LUMonetaryValue *firstValue = [LUMonetaryValue monetaryValueWithUSCents:@5];
      NSNumber *multiplier = @5;

      [[[firstValue valueByMultiplyingBy:multiplier] should] equal:[LUMonetaryValue monetaryValueWithUSCents:@25]];
    });
  });

  describe(@"valueBySubtractingValue:", ^{
    it(@"returns the result of subtracting this LUMonetaryValue by the number provided", ^{
      LUMonetaryValue *firstValue = [LUMonetaryValue monetaryValueWithUSCents:@100];
      LUMonetaryValue *secondValue = [LUMonetaryValue monetaryValueWithUSCents:@20];

      [[[firstValue valueBySubtractingValue:secondValue] should] equal:[LUMonetaryValue monetaryValueWithUSCents:@80]];
    });

    context(@"when the subtractor is larger than this LUMonetaryValue", ^{
      it(@"raises an assertion failure", ^{
        LUMonetaryValue *firstValue = [LUMonetaryValue monetaryValueWithUSCents:@20];
        LUMonetaryValue *secondValue = [LUMonetaryValue monetaryValueWithUSCents:@100];

        [[theBlock(^{
          [firstValue valueBySubtractingValue:secondValue];
        }) should] raise];
      });
    });
  });
});

SPEC_END
