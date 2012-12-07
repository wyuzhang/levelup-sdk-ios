#import "LUUser.h"

SPEC_BEGIN(LUUserSpec)

describe(@"LUUser", ^{
  LUUser *userA = [[LUUser alloc] init];
  LUUser *userB = [[LUUser alloc] init];
  NSString *firstNameA = @"Alfred";
  NSString *firstNameB = @"Bobba";

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      userA.firstName = firstNameA;
      userB.firstName = firstNameA;

      [[theValue([userA isEqual:userB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      userA.firstName = firstNameA;
      userB.firstName = firstNameA;

      [[theValue([userB isEqual:userA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      userA.firstName = firstNameA;
      userB.firstName = firstNameA;

      [[theValue([userA isEqual:userB]) should] equal:theValue(YES)];

      userB.firstName = firstNameB;

      [[theValue([userA isEqual:userB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      userB.firstName = firstNameA;
      userB.firstName = firstNameB;

      [[theValue([userA isEqual:userB]) should] equal:theValue(NO)];

      userB.firstName = firstNameA;

      [[theValue([userA isEqual:userB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      userA.firstName = firstNameA;
      userB.firstName = firstNameA;

      [[theValue([userA hash]) should] equal:theValue([userB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      userA.firstName = firstNameA;
      userB.firstName = firstNameA;

      [[theValue([userA hash]) should] equal:theValue([userB hash])];

      userB.firstName = firstNameB;

      [[theValue([userA hash]) shouldNot] equal:theValue([userB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      userA.firstName = firstNameA;
      userB.firstName = firstNameB;

      [[theValue([userA hash]) shouldNot] equal:theValue([userB hash])];

      userB.firstName = firstNameA;

      [[theValue([userA hash]) should] equal:theValue([userB hash])];
    });
  });
});

SPEC_END
