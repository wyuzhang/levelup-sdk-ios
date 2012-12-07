#import "LUClaim.h"
#import "LUCohort.h"

SPEC_BEGIN(LUClaimSpec)

describe(@"LUClaim", ^{
  LUClaim *claimA = [[LUClaim alloc] init];
  LUClaim *claimB = [[LUClaim alloc] init];
  LUCohort *cohortA = [[LUCohort alloc] init];
  LUCohort *cohortB = [[LUCohort alloc] init];
  cohortA.description = @"cohortA";
  cohortB.description = @"cohortB";

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      [claimA setCohort:cohortA];
      claimB.cohort = cohortA;

      [[theValue([claimA isEqual:claimB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      claimA.cohort = cohortA;
      claimB.cohort = cohortA;

      [[theValue([claimB isEqual:claimA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      claimA.cohort = cohortA;
      claimB.cohort = cohortA;

      [[theValue([claimA isEqual:claimB]) should] equal:theValue(YES)];

      claimB.cohort = cohortB;

      [[theValue([claimA isEqual:claimB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      claimB.cohort = cohortA;
      claimB.cohort = cohortB;

      [[theValue([claimA isEqual:claimB]) should] equal:theValue(NO)];

      claimB.cohort = cohortA;

      [[theValue([claimA isEqual:claimB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      claimA.cohort = cohortA;
      claimB.cohort = cohortA;

      [[theValue([claimA hash]) should] equal:theValue([claimB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      claimA.cohort = cohortA;
      claimB.cohort = cohortA;

      [[theValue([claimA hash]) should] equal:theValue([claimB hash])];

      claimB.cohort = cohortB;

      [[theValue([claimA hash]) shouldNot] equal:theValue([claimB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      claimA.cohort = cohortA;
      claimB.cohort = cohortB;

      [[theValue([claimA hash]) shouldNot] equal:theValue([claimB hash])];

      claimB.cohort = cohortA;

      [[theValue([claimA hash]) should] equal:theValue([claimB hash])];
    });
  });
});

SPEC_END
