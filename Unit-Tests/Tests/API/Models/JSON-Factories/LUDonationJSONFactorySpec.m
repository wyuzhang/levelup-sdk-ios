#import "LUDonationJSONFactory.h"

SPEC_BEGIN(LUDonationJSONFactorySpec)

describe(@"LUDonationJSONFactory", ^{
  __block LUDonationJSONFactory *factory;

  beforeEach(^{
    factory = [LUDonationJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUDonation", ^{
      LUDonation *donation = [factory createFromAttributes:[LUDonation fullJSONObject]];

      [[donation.cause should] equal:[LUCause fullCause]];
      [[donation.donationID should] equal:@1];
      [[donation.value should] equal:[LUMonetaryValue fullMonetaryValue]];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'donation'", ^{
      [[[factory rootKey] should] equal:@"donation"];
    });
  });
});

SPEC_END
