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

      [[order.balance should] equal:[LUMonetaryValue monetaryValueWithUSCents:@1000]];
      [[order.bundleClosedDate should] equal:[NSDate fixture]];
      [[order.bundleDescriptor should] equal:@"LevelUp"];
      [[order.contribution should] equal:[LUMonetaryValue monetaryValueWithUSCents:@50]];
      [[order.contributionTargetName should] equal:@"Test Charity"];
      [[order.createdDate should] equal:[NSDate fixture]];
      [[order.credit should] equal:[LUMonetaryValue monetaryValueWithUSCents:@100]];
      [[order.earn should] equal:[LUMonetaryValue monetaryValueWithUSCents:@250]];
      [[order.locationExtendedAddress should] equal:@"Apt E"];
      [[order.locationID should] equal:@1];
      [[order.locationLocality should] equal:@"Boston"];
      [[order.locationPostalCode should] equal:@"01234"];
      [[order.locationRegion should] equal:@"MA"];
      [[order.locationStreetAddress should] equal:@"1 Main St"];
      [[order.merchantID should] equal:@1];
      [[order.merchantName should] equal:@"Test Merchant"];
      [[order.refundedDate should] equal:[NSDate fixture]];
      [[order.spend should] equal:[LUMonetaryValue monetaryValueWithUSCents:@800]];
      [[order.tip should] equal:[LUMonetaryValue monetaryValueWithUSCents:@200]];
      [[order.total should] equal:[LUMonetaryValue monetaryValueWithUSCents:@1000]];
      [[order.transactedDate should] equal:[NSDate fixture]];
      [[order.UUID should] equal:@"abcd1234"];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'order'", ^{
      [[[factory rootKey] should] equal:@"order"];
    });
  });
});

SPEC_END
