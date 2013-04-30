#import "LUOrderJSONFactory.h"

SPEC_BEGIN(LUOrderJSONFactorySpec)

describe(@"LUOrderJSONFactory", ^{
  __block LUOrderJSONFactory *factory;

  beforeEach(^{
    factory = [LUOrderJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUOrder", ^{
      LUOrder *order = [factory createFromAttributes:[LUOrder fullJSONObject]];

      [[order.balance should] equal:[LUMonetaryValue fullMonetaryValue]];
      [[theValue(order.closed) should] beNo];
      [[order.createdDate should] equal:[NSDate fixture]];
      [[order.credit should] equal:[LUMonetaryValue fullMonetaryValue]];
      [[order.donation should] equal:[LUDonation fullDonation]];
      [[order.earn should] equal:[LUMonetaryValue fullMonetaryValue]];
      [[order.interstitialAction should] equal:[LUInterstitialAction fullInterstitialAction]];
      [[order.location should] equal:[LULocation fullLocation]];
      [[order.loyalty should] equal:[LULoyalty fullLoyalty]];
      [[order.merchant should] equal:[LUMerchant minimalMerchant]];
      [[order.orderID should] equal:@1];
      [[order.refundedDate should] equal:[NSDate fixture]];
      [[order.spend should] equal:[LUMonetaryValue fullMonetaryValue]];
      [[theValue(order.state) should] equal:theValue(LUOrderProcessing)];
      [[order.tip should] equal:[LUMonetaryValue fullMonetaryValue]];
      [[order.total should] equal:[LUMonetaryValue fullMonetaryValue]];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'order'", ^{
      [[[factory rootKey] should] equal:@"order"];
    });
  });
});

SPEC_END
