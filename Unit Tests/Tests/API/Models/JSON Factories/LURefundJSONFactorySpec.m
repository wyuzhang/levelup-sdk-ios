#import "LURefundJSONFactory.h"

SPEC_BEGIN(LURefundJSONFactorySpec)

describe(@"LURefundJSONFactory", ^{
  __block LURefundJSONFactory *factory;

  beforeEach(^{
    factory = [LURefundJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LURefund", ^{
      LURefund *refund = [factory createFromAttributes:[LURefund fullJSONObject]];

      [[refund.createdDate should] equal:[NSDate fixture]];
      [[refund.order should] equal:[LUOrder fullOrder]];
      [[refund.refundID should] equal:@1];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'refund'", ^{
      [[[factory rootKey] should] equal:@"refund"];
    });
  });
});

SPEC_END
