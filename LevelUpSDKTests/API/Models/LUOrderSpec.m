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

  __block LUOrder *order;

  beforeEach(^{
    order = [[LUOrder alloc] init];
  });

  describe(@"hasDonation", ^{
    context(@"when donation is nil", ^{
      beforeEach(^{
        order.donation = nil;
      });

      it(@"is NO", ^{
        [[theValue([order hasDonation]) should] beNo];
      });
    });

    context(@"when there is donation with 0 value", ^{
      beforeEach(^{
        order.donation = [[LUDonation alloc] init];
        order.donation.value = [LUMonetaryValue monetaryValueWithUSD:@0.0f];
      });

      it(@"is NO", ^{
        [[theValue([order hasDonation]) should] beNo];
      });
    });

    context(@"when there is donation positive value", ^{
      beforeEach(^{
        order.donation = [[LUDonation alloc] init];
        order.donation.value = [LUMonetaryValue monetaryValueWithUSD:@2.0f];
      });

      it(@"is YES", ^{
        [[theValue([order hasDonation]) should] beYes];
      });
    });
  });

  describe(@"hasEarnedCredit", ^{
    context(@"when earn is nil", ^{
      beforeEach(^{
        order.earn = nil;
      });

      it(@"is NO", ^{
        [[theValue([order hasEarnedCredit]) should] beNo];
      });
    });

    context(@"when earn is 0", ^{
      beforeEach(^{
        order.earn = [LUMonetaryValue monetaryValueWithUSD:@0.0f];
      });

      it(@"is NO", ^{
        [[theValue([order hasEarnedCredit]) should] beNo];
      });
    });

    context(@"when earn is positive", ^{
      beforeEach(^{
        order.earn = [LUMonetaryValue monetaryValueWithUSD:@2.0f];
      });

      it(@"is YES", ^{
        [[theValue([order hasEarnedCredit]) should] beYes];
      });
    });
  });

  describe(@"hasNonZeroBalance", ^{
    context(@"when balance is nil", ^{
      beforeEach(^{
        order.balance = nil;
      });

      it(@"is NO", ^{
        [[theValue([order hasNonZeroBalance]) should] beNo];
      });
    });

    context(@"when balance is 0", ^{
      beforeEach(^{
        order.balance = [LUMonetaryValue monetaryValueWithUSD:@0.0f];
      });

      it(@"is NO", ^{
        [[theValue([order hasNonZeroBalance]) should] beNo];
      });
    });

    context(@"when balance is non-zero", ^{
      beforeEach(^{
        order.balance = [LUMonetaryValue monetaryValueWithUSD:@-2.0f];
      });

      it(@"is YES", ^{
        [[theValue([order hasNonZeroBalance]) should] beYes];
      });
    });
  });

  describe(@"hasTipApplied", ^{
    context(@"when tip is nil", ^{
      beforeEach(^{
        order.tip = nil;
      });

      it(@"is NO", ^{
        [[theValue([order hasTipApplied]) should] beNo];
      });
    });

    context(@"when tip is 0", ^{
      beforeEach(^{
        order.tip = [LUMonetaryValue monetaryValueWithUSD:@0.0f];
      });

      it(@"is NO", ^{
        [[theValue([order hasTipApplied]) should] beNo];
      });
    });

    context(@"when tip is positive", ^{
      beforeEach(^{
        order.tip = [LUMonetaryValue monetaryValueWithUSD:@2.0f];
      });

      it(@"is YES", ^{
        [[theValue([order hasTipApplied]) should] beYes];
      });
    });
  });

  describe(@"hasUsedCredit", ^{
    context(@"when credit is nil", ^{
      beforeEach(^{
        order.credit = nil;
      });

      it(@"is NO", ^{
        [[theValue([order hasUsedCredit]) should] beNo];
      });
    });

    context(@"when credit is 0", ^{
      beforeEach(^{
        order.credit = [LUMonetaryValue monetaryValueWithUSD:@0.0f];
      });

      it(@"is NO", ^{
        [[theValue([order hasUsedCredit]) should] beNo];
      });
    });

    context(@"when credit is positive", ^{
      beforeEach(^{
        order.credit = [LUMonetaryValue monetaryValueWithUSD:@2.0f];
      });

      it(@"is YES", ^{
        [[theValue([order hasUsedCredit]) should] beYes];
      });
    });
  });

  describe(@"wasRefunded", ^{
    context(@"when refundedAt is nil", ^{
      beforeEach(^{
        [order setValue:nil forKey:@"refundedAt"];
      });

      it(@"is NO", ^{
        [[theValue([order wasRefunded]) should] beNo];
      });
    });

    context(@"when refundedAt is non-nil", ^{
      beforeEach(^{
        [order setValue:[NSDate date] forKey:@"refundedAt"];
      });

      it(@"is YES", ^{
        [[theValue([order wasRefunded]) should] beYes];
      });
    });
  });
});

SPEC_END
