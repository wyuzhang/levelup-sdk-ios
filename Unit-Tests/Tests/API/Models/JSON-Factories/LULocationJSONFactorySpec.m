#import "LULocationJSONFactory.h"

SPEC_BEGIN(LULocationJSONFactorySpec)

describe(@"LULocationJSONFactory", ^{
  __block LULocationJSONFactory *factory;

  beforeEach(^{
    factory = [LULocationJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LULocation", ^{
      LULocation *location = [factory createFromAttributes:[LULocation fullJSONObject]];

      [[location.extendedAddress should] equal:@"Apt E"];
      [[location.hours should] equal:@"M-F 9am-5pm"];
      [[location.latitude should] equal:@70];
      [[location.locality should] equal:@"Boston"];
      [[location.locationID should] equal:@1];
      [[location.longitude should] equal:@-45];
      [[location.merchantID should] equal:@2];
      [[location.name should] equal:@"Test Location"];
      [[location.phone should] equal:@"617-123-1234"];
      [[location.postalCode should] equal:@"01234"];
      [[location.region should] equal:@"MA"];
      [[theValue(location.shown) should] beYes];
      [[location.streetAddress should] equal:@"1 Main St"];
      [[theValue(location.summary) should] beNo];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'location'", ^{
      [[[factory rootKey] should] equal:@"location"];
    });
  });
});

SPEC_END
