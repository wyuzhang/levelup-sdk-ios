#import "LUUserAddress.h"

SPEC_BEGIN(LUUserAddressSpec)

describe(@"LUUserAddress", ^{
  LUUserAddress *userAddressA = [[LUUserAddress alloc] init];
  LUUserAddress *userAddressB = [[LUUserAddress alloc] init];
  NSString *localityA = @"en";
  NSString *localityB = @"fr";

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      userAddressA.locality = localityA;
      userAddressB.locality = localityA;

      [[theValue([userAddressA isEqual:userAddressB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      userAddressA.locality = localityA;
      userAddressB.locality = localityA;

      [[theValue([userAddressB isEqual:userAddressA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      userAddressA.locality = localityA;
      userAddressB.locality = localityA;

      [[theValue([userAddressA isEqual:userAddressB]) should] equal:theValue(YES)];

      userAddressB.locality = localityB;

      [[theValue([userAddressA isEqual:userAddressB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      userAddressB.locality = localityA;
      userAddressB.locality = localityB;

      [[theValue([userAddressA isEqual:userAddressB]) should] equal:theValue(NO)];

      userAddressB.locality = localityA;

      [[theValue([userAddressA isEqual:userAddressB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      userAddressA.locality = localityA;
      userAddressB.locality = localityA;

      [[theValue([userAddressA hash]) should] equal:theValue([userAddressB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      userAddressA.locality = localityA;
      userAddressB.locality = localityA;

      [[theValue([userAddressA hash]) should] equal:theValue([userAddressB hash])];

      userAddressB.locality = localityB;

      [[theValue([userAddressA hash]) shouldNot] equal:theValue([userAddressB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      userAddressA.locality = localityA;
      userAddressB.locality = localityB;

      [[theValue([userAddressA hash]) shouldNot] equal:theValue([userAddressB hash])];

      userAddressB.locality = localityA;

      [[theValue([userAddressA hash]) should] equal:theValue([userAddressB hash])];
    });
  });
});

SPEC_END
