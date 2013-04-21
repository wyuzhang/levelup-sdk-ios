#import "LUBundle.h"
#import "LUMonetaryValue.h"
#import "LUOrder.h"
#import "LURefund.h"
#import "NSDate+StringFormats.h"

SPEC_BEGIN(LUBundleSpec)

describe(@"LUBundle", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUBundle class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Public Methods

  describe(@"hasChargeData", ^{
    context(@"when chargeDate is nil", ^{
      LUBundle *bundle = [[LUBundle alloc] init];

      it(@"is NO", ^{
        [[theValue([bundle hasChargeData]) should] beNo];
      });
    });

    context(@"when chargeDate is non-nil", ^{
      LUBundle *bundle = [LUBundle fakeInstance];

      it(@"is YES", ^{
        [[theValue([bundle hasChargeData]) should] beYes];
      });
    });
  });

  describe(@"hasNonZeroBalance", ^{
    context(@"when amount is nil", ^{
      LUBundle *bundle = [[LUBundle alloc] init];

      it(@"is NO", ^{
        [[theValue([bundle hasNonZeroBalance]) should] beNo];
      });
    });

    context(@"when the amount is 0", ^{
      LUBundle *bundle = [LUBundle fakeInstanceWithAmount:[LUMonetaryValue monetaryValueWithUSD:@0.0f]];

      it(@"is NO", ^{
        [[theValue([bundle hasNonZeroBalance]) should] beNo];
      });
    });

    context(@"when amount is non-zero", ^{
      LUBundle *bundle = [LUBundle fakeInstanceWithAmount:[LUMonetaryValue monetaryValueWithUSD:@1.0f]];

      it(@"is YES", ^{
        [[theValue([bundle hasNonZeroBalance]) should] beYes];
      });
    });
  });

  describe(@"hasSavings", ^{
    context(@"when totalCreditUsed is nil", ^{
      LUBundle *bundle = [[LUBundle alloc] init];

      it(@"is NO", ^{
        [[theValue([bundle hasSavings]) should] beNo];
      });
    });

    context(@"when totalCreditUsed is 0", ^{
      LUBundle *bundle = [LUBundle fakeInstanceWithTotalCreditUsed:[LUMonetaryValue monetaryValueWithUSD:@0.0f]];

      it(@"is NO", ^{
        [[theValue([bundle hasSavings]) should] beNo];
      });
    });

    context(@"when totalCreditUsed is non-zero", ^{
      LUBundle *bundle = [LUBundle fakeInstanceWithTotalCreditUsed:[LUMonetaryValue monetaryValueWithUSD:@1.0f]];

      it(@"is YES", ^{
        [[theValue([bundle hasSavings]) should] beYes];
      });
    });
  });

  describe(@"ordersAndRefunds", ^{
    it(@"returns the set of orders and refunds, ordered by creation date descending", ^{
      LUOrder *order1 = [[LUOrder alloc] init];
      [order1 stub:@selector(createdDate) andReturn:[NSDate dateWithTimeIntervalSince1970:1350000000]];

      LUOrder *order2 = [[LUOrder alloc] init];
      [order2 stub:@selector(createdDate) andReturn:[NSDate dateWithTimeIntervalSince1970:1360000000]];

      LURefund *refund1 = [[LURefund alloc] init];
      [refund1 stub:@selector(createdDate) andReturn:[NSDate dateWithTimeIntervalSince1970:1340000000]];

      LURefund *refund2 = [[LURefund alloc] init];
      [refund2 stub:@selector(createdDate) andReturn:[NSDate dateWithTimeIntervalSince1970:1370000000]];

      LUBundle *bundle = [LUBundle fakeInstanceWithOrders:@[order1, order2] refunds:@[refund1, refund2]];

      [[bundle.ordersAndRefunds should] equal:@[refund2, order2, order1, refund1]];
    });
  });
});

SPEC_END
