#import "LUDonation.h"
#import "LUMonetaryValue.h"
#import "LUOrder.h"
#import "NSDate+StringFormats.h"

SPEC_BEGIN(LUOrderSpec)

describe(@"LUOrder", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUOrder class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Public Methods

  describe(@"hasDonation", ^{
    context(@"when donation is nil", ^{
      LUOrder *order = [LUOrder fakeInstanceWithoutDonation];

      it(@"is NO", ^{
        [[theValue([order hasDonation]) should] beNo];
      });
    });

    context(@"when there is donation with 0 value", ^{
      LUDonation *donation = [[LUDonation alloc] initWithCause:nil
                                                    donationID:nil
                                                         value:[LUMonetaryValue monetaryValueWithUSD:@0.0f]];
      LUOrder *order = [LUOrder fakeInstanceWithDonation:donation];

      it(@"is NO", ^{
        [[theValue([order hasDonation]) should] beNo];
      });
    });

    context(@"when there is donation with positive value", ^{
      LUDonation *donation = [[LUDonation alloc] initWithCause:nil
                                                    donationID:nil
                                                         value:[LUMonetaryValue monetaryValueWithUSD:@2.0f]];
      LUOrder *order = [LUOrder fakeInstanceWithDonation:donation];

      it(@"is YES", ^{
        [[theValue([order hasDonation]) should] beYes];
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
