#import "LUBundle.h"

SPEC_BEGIN(LUBundleSpec)

describe(@"LUBundle", ^{
  LUBundle *bundleA = [[LUBundle alloc] init];
  LUBundle *bundleB = [[LUBundle alloc] init];
  NSString *last4A = @"1234";
  NSString *last4B = @"2345";

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      bundleA.last_4 = last4A;
      bundleB.last_4 = last4A;

      [[theValue([bundleA isEqual:bundleB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      bundleA.last_4 = last4A;
      bundleB.last_4 = last4A;

      [[theValue([bundleB isEqual:bundleA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      bundleA.last_4 = last4A;
      bundleB.last_4 = last4A;

      [[theValue([bundleA isEqual:bundleB]) should] equal:theValue(YES)];

      bundleB.last_4 = last4B;

      [[theValue([bundleA isEqual:bundleB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      bundleB.last_4 = last4A;
      bundleB.last_4 = last4B;

      [[theValue([bundleA isEqual:bundleB]) should] equal:theValue(NO)];

      bundleB.last_4 = last4A;

      [[theValue([bundleA isEqual:bundleB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      bundleA.last_4 = last4A;
      bundleB.last_4 = last4A;

      [[theValue([bundleA hash]) should] equal:theValue([bundleB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      bundleA.last_4 = last4A;
      bundleB.last_4 = last4A;

      [[theValue([bundleA hash]) should] equal:theValue([bundleB hash])];

      bundleB.last_4 = last4B;

      [[theValue([bundleA hash]) shouldNot] equal:theValue([bundleB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      bundleA.last_4 = last4A;
      bundleB.last_4 = last4B;

      [[theValue([bundleA hash]) shouldNot] equal:theValue([bundleB hash])];

      bundleB.last_4 = last4A;

      [[theValue([bundleA hash]) should] equal:theValue([bundleB hash])];
    });
  });
});

SPEC_END
