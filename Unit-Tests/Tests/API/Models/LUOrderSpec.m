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
#import "LUOrder.h"
#import "NSURL+LUAdditions.h"

SPEC_BEGIN(LUOrderSpec)

describe(@"LUOrder", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUOrder class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Public Methods

  describe(@"closed", ^{
    context(@"when bundleClosedDate is nil", ^{
      LUOrder *order = [LUOrder fixtureWithBundleOpen];

      it(@"is NO", ^{
        [[theValue([order closed]) should] beNo];
      });
    });

    context(@"when bundleClosedDate is non-nil", ^{
      LUOrder *order = [LUOrder fixture];

      it(@"is YES", ^{
        [[theValue([order closed]) should] beYes];
      });
    });
  });

  describe(@"hasContribution", ^{
    context(@"when contribution is nil", ^{
      LUOrder *order = [LUOrder fixtureWithoutContribution];

      it(@"is NO", ^{
        [[theValue([order hasContribution]) should] beNo];
      });
    });

    context(@"when there is contribution with 0 value", ^{
      LUOrder *order = [LUOrder fixtureWithContribution:[LUMonetaryValue monetaryValueWithUSD:@0.0f]];

      it(@"is NO", ^{
        [[theValue([order hasContribution]) should] beNo];
      });
    });

    context(@"when there is donaticontributionon with positive value", ^{
      LUOrder *order = [LUOrder fixtureWithContribution:[LUMonetaryValue monetaryValueWithUSD:@2.0f]];

      it(@"is YES", ^{
        [[theValue([order hasContribution]) should] beYes];
      });
    });
  });

  describe(@"hasEarnedCredit", ^{
    context(@"when earn is nil", ^{
      LUOrder *order = [LUOrder fixtureWithOnlySpend];

      it(@"is NO", ^{
        [[theValue([order hasEarnedCredit]) should] beNo];
      });
    });

    context(@"when earn is 0", ^{
      LUOrder *order = [LUOrder fixtureWithEarn:[LUMonetaryValue monetaryValueWithUSD:@0.0f]];

      it(@"is NO", ^{
        [[theValue([order hasEarnedCredit]) should] beNo];
      });
    });

    context(@"when earn is positive", ^{
      LUOrder *order = [LUOrder fixtureWithEarn:[LUMonetaryValue monetaryValueWithUSD:@2.0f]];

      it(@"is YES", ^{
        [[theValue([order hasEarnedCredit]) should] beYes];
      });
    });
  });

  describe(@"hasNonZeroBalance", ^{
    context(@"when balance is 0", ^{
      LUOrder *order = [LUOrder fixtureWithZeroBalance];

      it(@"is NO", ^{
        [[theValue([order hasNonZeroBalance]) should] beNo];
      });
    });

    context(@"when balance is non-zero", ^{
      LUOrder *order = [LUOrder fixture];

      it(@"is YES", ^{
        [[theValue([order hasNonZeroBalance]) should] beYes];
      });
    });
  });

  describe(@"hasTipApplied", ^{
    context(@"when tip is nil", ^{
      LUOrder *order = [LUOrder fixtureWithoutTip];

      it(@"is NO", ^{
        [[theValue([order hasTipApplied]) should] beNo];
      });
    });

    context(@"when tip is 0", ^{
      LUOrder *order = [LUOrder fixtureWithTip:[LUMonetaryValue monetaryValueWithUSD:@0.0f]];

      it(@"is NO", ^{
        [[theValue([order hasTipApplied]) should] beNo];
      });
    });

    context(@"when tip is positive", ^{
      LUOrder *order = [LUOrder fixtureWithTip:[LUMonetaryValue monetaryValueWithUSD:@2.0f]];

      it(@"is YES", ^{
        [[theValue([order hasTipApplied]) should] beYes];
      });
    });
  });

  describe(@"hasUsedCredit", ^{
    context(@"when credit is nil", ^{
      LUOrder *order = [LUOrder fixtureWithCredit:nil];

      it(@"is NO", ^{
        [[theValue([order hasUsedCredit]) should] beNo];
      });
    });

    context(@"when credit is 0", ^{
      LUOrder *order = [LUOrder fixtureWithCredit:[LUMonetaryValue monetaryValueWithUSD:@0.0f]];

      it(@"is NO", ^{
        [[theValue([order hasUsedCredit]) should] beNo];
      });
    });

    context(@"when credit is positive", ^{
      LUOrder *order = [LUOrder fixtureWithCredit:[LUMonetaryValue monetaryValueWithUSD:@2.0f]];

      it(@"is YES", ^{
        [[theValue([order hasUsedCredit]) should] beYes];
      });
    });
  });

  describe(@"imageURL", ^{
    LUOrder *order = [LUOrder fixture];
    NSURL *URL = [NSURL URLWithString:@"http://example.com/path/to/image"];

    beforeEach(^{
      [NSURL stub:@selector(lu_imageURLForLocationWithID:) andReturn:URL withArguments:order.locationID, nil];
    });

    it(@"returns the URL of the location image request", ^{
      [[[order imageURL] should] equal:URL];
    });
  });

  describe(@"singleLineAddress", ^{
    LUOrder *order = [LUOrder fixture];

    it(@"is combination of all the address elements", ^{
      NSString *expected = [NSString stringWithFormat:@"%@, %@, %@, %@ %@",
                            order.locationStreetAddress, order.locationExtendedAddress, order.locationLocality,
                            order.locationRegion, order.locationPostalCode];

      [[[order singleLineAddress] should] equal:expected];
    });
  });

  describe(@"wasRefunded", ^{
    context(@"when refundedDate is nil", ^{
      LUOrder *order = [LUOrder fixture];

      it(@"is NO", ^{
        [[theValue([order wasRefunded]) should] beNo];
      });
    });

    context(@"when refundedDate is non-nil", ^{
      LUOrder *order = [LUOrder fixtureWithRefundedStatus];

      it(@"is YES", ^{
        [[theValue([order wasRefunded]) should] beYes];
      });
    });
  });
});

SPEC_END
