#import "LULocation.h"

SPEC_BEGIN(LULocationSpec)

describe(@"LULocation", ^{
  LULocation *locationA = [[LULocation alloc] init];
  LULocation *locationB = [[LULocation alloc] init];
  NSString *postA = @"12345";
  NSString *postB = @"54321";

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      locationA.postalCode = postA;
      locationB.postalCode = postA;

      [[theValue([locationA isEqual:locationB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      locationA.postalCode = postA;
      locationB.postalCode = postA;

      [[theValue([locationB isEqual:locationA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      locationA.postalCode = postA;
      locationB.postalCode = postA;

      [[theValue([locationA isEqual:locationB]) should] equal:theValue(YES)];

      locationB.postalCode = postB;

      [[theValue([locationA isEqual:locationB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      locationB.postalCode = postA;
      locationB.postalCode = postB;

      [[theValue([locationA isEqual:locationB]) should] equal:theValue(NO)];

      locationB.postalCode = postA;

      [[theValue([locationA isEqual:locationB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      locationA.postalCode = postA;
      locationB.postalCode = postA;

      [[theValue([locationA hash]) should] equal:theValue([locationB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      locationA.postalCode = postA;
      locationB.postalCode = postA;

      [[theValue([locationA hash]) should] equal:theValue([locationB hash])];

      locationB.postalCode = postB;

      [[theValue([locationA hash]) shouldNot] equal:theValue([locationB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      locationA.postalCode = postA;
      locationB.postalCode = postB;

      [[theValue([locationA hash]) shouldNot] equal:theValue([locationB hash])];

      locationB.postalCode = postA;

      [[theValue([locationA hash]) should] equal:theValue([locationB hash])];
    });
  });
});

SPEC_END
