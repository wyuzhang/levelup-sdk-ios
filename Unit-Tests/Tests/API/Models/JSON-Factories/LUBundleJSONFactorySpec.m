#import "LUBundleJSONFactory.h"

SPEC_BEGIN(LUBundleJSONFactorySpec)

describe(@"LUBundleJSONFactory", ^{
  __block LUBundleJSONFactory *factory;

  beforeEach(^{
    factory = [LUBundleJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUBundle", ^{
      LUBundle *bundle = [factory createFromAttributes:[LUBundle fullJSONObject]];

      [[bundle.amount should] equal:[LUMonetaryValue fullMonetaryValue]];
      [[bundle.bundleID should] equal:@1];
      [[bundle.chargeDate should] equal:[NSDate fixture]];
      [[theValue(bundle.closed) should] beYes];
      [[bundle.createdDate should] equal:[NSDate fixture]];
      [[bundle.last4CreditCardDigits should] equal:@"1234"];
      [[bundle.orders should] equal:@[[LUOrder fullOrder]]];
      [[bundle.refunds should] equal:@[[LURefund fullRefund]]];
      [[bundle.totalCreditUsed should] equal:[LUMonetaryValue fullMonetaryValue]];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'bundle'", ^{
      [[[factory rootKey] should] equal:@"bundle"];
    });
  });
});

SPEC_END
