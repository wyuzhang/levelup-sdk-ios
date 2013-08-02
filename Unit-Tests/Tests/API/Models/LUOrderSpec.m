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
      LUOrder *order = [LUOrder fakeInstanceWithBundleOpen];

      it(@"is NO", ^{
        [[theValue([order closed]) should] beNo];
      });
    });

    context(@"when bundleClosedDate is non-nil", ^{
      LUOrder *order = [LUOrder fakeInstance];

      it(@"is YES", ^{
        [[theValue([order closed]) should] beYes];
      });
    });
  });

  describe(@"hasContribution", ^{
    context(@"when contribution is nil", ^{
      LUOrder *order = [LUOrder fakeInstanceWithoutContribution];

      it(@"is NO", ^{
        [[theValue([order hasContribution]) should] beNo];
      });
    });

    context(@"when there is contribution with 0 value", ^{
      LUOrder *order = [LUOrder fakeInstanceWithContribution:[LUMonetaryValue monetaryValueWithUSD:@0.0f]];

      it(@"is NO", ^{
        [[theValue([order hasContribution]) should] beNo];
      });
    });

    context(@"when there is donaticontributionon with positive value", ^{
      LUOrder *order = [LUOrder fakeInstanceWithContribution:[LUMonetaryValue monetaryValueWithUSD:@2.0f]];

      it(@"is YES", ^{
        [[theValue([order hasContribution]) should] beYes];
      });
    });
  });

  describe(@"hasEarnedCredit", ^{
    context(@"when earn is nil", ^{
      LUOrder *order = [LUOrder fakeInstanceWithOnlySpend];

      it(@"is NO", ^{
        [[theValue([order hasEarnedCredit]) should] beNo];
      });
    });

    context(@"when earn is 0", ^{
      LUOrder *order = [LUOrder fakeInstanceWithEarn:[LUMonetaryValue monetaryValueWithUSD:@0.0f]];

      it(@"is NO", ^{
        [[theValue([order hasEarnedCredit]) should] beNo];
      });
    });

    context(@"when earn is positive", ^{
      LUOrder *order = [LUOrder fakeInstanceWithEarn:[LUMonetaryValue monetaryValueWithUSD:@2.0f]];

      it(@"is YES", ^{
        [[theValue([order hasEarnedCredit]) should] beYes];
      });
    });
  });

  describe(@"hasNonZeroBalance", ^{
    context(@"when balance is 0", ^{
      LUOrder *order = [LUOrder fakeInstanceWithZeroBalance];

      it(@"is NO", ^{
        [[theValue([order hasNonZeroBalance]) should] beNo];
      });
    });

    context(@"when balance is non-zero", ^{
      LUOrder *order = [LUOrder fakeInstance];

      it(@"is YES", ^{
        [[theValue([order hasNonZeroBalance]) should] beYes];
      });
    });
  });

  describe(@"hasTipApplied", ^{
    context(@"when tip is nil", ^{
      LUOrder *order = [LUOrder fakeInstanceWithoutTip];

      it(@"is NO", ^{
        [[theValue([order hasTipApplied]) should] beNo];
      });
    });

    context(@"when tip is 0", ^{
      LUOrder *order = [LUOrder fakeInstanceWithTip:[LUMonetaryValue monetaryValueWithUSD:@0.0f]];

      it(@"is NO", ^{
        [[theValue([order hasTipApplied]) should] beNo];
      });
    });

    context(@"when tip is positive", ^{
      LUOrder *order = [LUOrder fakeInstanceWithTip:[LUMonetaryValue monetaryValueWithUSD:@2.0f]];

      it(@"is YES", ^{
        [[theValue([order hasTipApplied]) should] beYes];
      });
    });
  });

  describe(@"hasUsedCredit", ^{
    context(@"when credit is nil", ^{
      LUOrder *order = [LUOrder fakeInstanceWithCredit:nil];

      it(@"is NO", ^{
        [[theValue([order hasUsedCredit]) should] beNo];
      });
    });

    context(@"when credit is 0", ^{
      LUOrder *order = [LUOrder fakeInstanceWithCredit:[LUMonetaryValue monetaryValueWithUSD:@0.0f]];

      it(@"is NO", ^{
        [[theValue([order hasUsedCredit]) should] beNo];
      });
    });

    context(@"when credit is positive", ^{
      LUOrder *order = [LUOrder fakeInstanceWithCredit:[LUMonetaryValue monetaryValueWithUSD:@2.0f]];

      it(@"is YES", ^{
        [[theValue([order hasUsedCredit]) should] beYes];
      });
    });
  });

  describe(@"imageURL", ^{
    LUOrder *order = [LUOrder fakeInstance];
    NSURL *URL = [NSURL URLWithString:@"http://example.com/path/to/image"];

    beforeEach(^{
      [NSURL stub:@selector(lu_imageURLForLocationWithID:) andReturn:URL withArguments:order.locationID];
    });

    it(@"returns the URL of the location image request", ^{
      [[[order imageURL] should] equal:URL];
    });
  });

  describe(@"singleLineAddress", ^{
    LUOrder *order = [LUOrder fakeInstance];

    it(@"is combination of all the address elements", ^{
      NSString *expected = [NSString stringWithFormat:@"%@, %@, %@, %@ %@",
                            order.locationStreetAddress, order.locationExtendedAddress, order.locationLocality,
                            order.locationRegion, order.locationPostalCode];

      [[[order singleLineAddress] should] equal:expected];
    });
  });

  describe(@"wasRefunded", ^{
    context(@"when refundedDate is nil", ^{
      LUOrder *order = [LUOrder fakeInstance];

      it(@"is NO", ^{
        [[theValue([order wasRefunded]) should] beNo];
      });
    });

    context(@"when refundedDate is non-nil", ^{
      LUOrder *order = [LUOrder fakeInstanceWithRefundedStatus];

      it(@"is YES", ^{
        [[theValue([order wasRefunded]) should] beYes];
      });
    });
  });
});

SPEC_END
