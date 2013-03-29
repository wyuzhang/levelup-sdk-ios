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

  __block LUBundle *bundle;

  beforeEach(^{
    bundle = [[LUBundle alloc] init];
  });

  describe(@"chargeDate", ^{
    it(@"returns chargedAt as an NSDate", ^{
      NSDate *date = [NSDate date];
      NSString *dateString = [date iso8601DateTimeString];
      [bundle setValue:dateString forKey:@"chargedAt"];

      [[theValue([[bundle chargeDate] timeIntervalSince1970]) should] equal:[date timeIntervalSince1970] withDelta:1.0];
    });
  });

  describe(@"creationDate", ^{
    it(@"returns createdAt as an NSDate", ^{
      NSDate *date = [NSDate date];
      NSString *dateString = [date iso8601DateTimeString];
      [bundle setValue:dateString forKey:@"createdAt"];

      [[theValue([[bundle creationDate] timeIntervalSince1970]) should] equal:[date timeIntervalSince1970] withDelta:1.0];
    });
  });

  describe(@"hasChargeData", ^{
    context(@"when chargedAt is nil", ^{
      beforeEach(^{
        [bundle setValue:nil forKey:@"chargedAt"];
      });

      it(@"is NO", ^{
        [[theValue([bundle hasChargeData]) should] beNo];
      });
    });

    context(@"when chargedAt is non-nil", ^{
      beforeEach(^{
        [bundle setValue:[NSDate date] forKey:@"chargedAt"];
      });

      it(@"is YES", ^{
        [[theValue([bundle hasChargeData]) should] beYes];
      });
    });
  });

  describe(@"hasNonZeroBalance", ^{
    context(@"when amount is nil", ^{
      beforeEach(^{
        bundle.amount = nil;
      });

      it(@"is NO", ^{
        [[theValue([bundle hasNonZeroBalance]) should] beNo];
      });
    });

    context(@"when the amount is 0", ^{
      beforeEach(^{
        bundle.amount = [LUMonetaryValue monetaryValueWithUSD:@0.0f];
      });

      it(@"is NO", ^{
        [[theValue([bundle hasNonZeroBalance]) should] beNo];
      });
    });

    context(@"when amount is non-zero", ^{
      beforeEach(^{
        bundle.amount = [LUMonetaryValue monetaryValueWithUSD:@1.0f];
      });

      it(@"is YES", ^{
        [[theValue([bundle hasNonZeroBalance]) should] beYes];
      });
    });
  });

  describe(@"hasSavings", ^{
    context(@"when totalCreditUsed is nil", ^{
      beforeEach(^{
        bundle.totalCreditUsed = nil;
      });

      it(@"is NO", ^{
        [[theValue([bundle hasSavings]) should] beNo];
      });
    });

    context(@"when totalCreditUsed is 0", ^{
      beforeEach(^{
        bundle.totalCreditUsed = [LUMonetaryValue monetaryValueWithUSD:@0.0f];
      });

      it(@"is NO", ^{
        [[theValue([bundle hasSavings]) should] beNo];
      });
    });

    context(@"when totalCreditUsed is non-zero", ^{
      beforeEach(^{
        bundle.totalCreditUsed = [LUMonetaryValue monetaryValueWithUSD:@1.0f];
      });

      it(@"is YES", ^{
        [[theValue([bundle hasSavings]) should] beYes];
      });
    });
  });

  describe(@"isClosed", ^{
    context(@"when the state is 'closed'", ^{
      beforeEach(^{
        [bundle setValue:@"closed" forKey:@"state"];
      });

      it(@"is YES", ^{
        [[theValue([bundle isClosed]) should] beYes];
      });
    });

    context(@"when the state is not 'closed'", ^{
      beforeEach(^{
        [bundle setValue:@"open" forKey:@"state"];
      });

      it(@"is NO", ^{
        [[theValue([bundle isClosed]) should] beNo];
      });
    });
  });

  describe(@"ordersAndRefunds", ^{
    it(@"returns the set of orders and refunds, ordered by creation date descending", ^{
      LUOrder *order1 = [[LUOrder alloc] init];
      [order1 setValue:[NSDate dateWithTimeIntervalSince1970:1350000000] forKey:@"createdAt"];

      LUOrder *order2 = [[LUOrder alloc] init];
      [order2 setValue:[NSDate dateWithTimeIntervalSince1970:1360000000] forKey:@"createdAt"];

      bundle.orders = @[order1, order2];

      LURefund *refund1 = [[LURefund alloc] init];
      [refund1 setValue:[NSDate dateWithTimeIntervalSince1970:1340000000] forKey:@"createdAt"];

      LURefund *refund2 = [[LURefund alloc] init];
      [refund2 setValue:[NSDate dateWithTimeIntervalSince1970:1370000000] forKey:@"createdAt"];

      bundle.refunds = @[refund1, refund2];

      [[bundle.ordersAndRefunds should] equal:@[refund2, order2, order1, refund1]];
    });
  });
});

SPEC_END
