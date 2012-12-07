#import "LUDonation.h"
#import "LUMonetaryValue.h"

SPEC_BEGIN(LUDonationSpec)

describe(@"LUDonation", ^{
  LUDonation *donationA = [[LUDonation alloc] init];
  LUDonation *donationB = [[LUDonation alloc] init];
  LUMonetaryValue *valueA = [[LUMonetaryValue alloc] init];
  [valueA setAmount:[NSNumber numberWithInt:1]];
  LUMonetaryValue *valueB = [[LUMonetaryValue alloc] init];
  [valueB setAmount:[NSNumber numberWithInt:2]];

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      donationA.value = valueA;
      donationB.value = valueA;

      [[theValue([donationA isEqual:donationB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      donationA.value = valueA;
      donationB.value = valueA;

      [[theValue([donationB isEqual:donationA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      donationA.value = valueA;
      donationB.value = valueA;

      [[theValue([donationA isEqual:donationB]) should] equal:theValue(YES)];

      donationB.value = valueB;

      [[theValue([donationA isEqual:donationB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      donationB.value = valueA;
      donationB.value = valueB;

      [[theValue([donationA isEqual:donationB]) should] equal:theValue(NO)];

      donationB.value = valueA;

      [[theValue([donationA isEqual:donationB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      donationA.value = valueA;
      donationB.value = valueA;

      [[theValue([donationA hash]) should] equal:theValue([donationB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      donationA.value = valueA;
      donationB.value = valueA;

      [[theValue([donationA hash]) should] equal:theValue([donationB hash])];

      donationB.value = valueB;

      [[theValue([donationA hash]) shouldNot] equal:theValue([donationB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      donationA.value = valueA;
      donationB.value = valueB;

      [[theValue([donationA hash]) shouldNot] equal:theValue([donationB hash])];

      donationB.value = valueA;

      [[theValue([donationA hash]) should] equal:theValue([donationB hash])];
    });
  });
});

SPEC_END
