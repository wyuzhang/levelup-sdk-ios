#import "LUUserAddressJSONFactory.h"

SPEC_BEGIN(LUUserAddressJSONFactorySpec)

describe(@"LUUserAddressJSONFactory", ^{
  __block LUUserAddressJSONFactory *factory;

  beforeEach(^{
    factory = [LUUserAddressJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUUserAddress", ^{
      LUUserAddress *address = [factory createFromAttributes:[LUUserAddress fullJSONObject]];

      [[address.addressType should] equal:@"home"];
      [[address.extendedAddress should] equal:@"Apt E"];
      [[address.locality should] equal:@"Boston"];
      [[address.postalCode should] equal:@"01234"];
      [[address.region should] equal:@"MA"];
      [[address.streetAddress should] equal:@"1 Main St"];
      [[address.userAddressID should] equal:@1];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'user_address'", ^{
      [[[factory rootKey] should] equal:@"user_address"];
    });
  });
});

SPEC_END
