#import "LUCohort.h"

SPEC_BEGIN(LUCohortSpec)

describe(@"LUCohort", ^{
  LUCohort *cohortA = [[LUCohort alloc] init];
  LUCohort *cohortB = [[LUCohort alloc] init];
  NSString *codeA = @"cohortA";
  NSString *codeB = @"cohortB";

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      cohortA.code = codeA;
      cohortB.code = codeA;

      [[theValue([cohortA isEqual:cohortB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      cohortA.code = codeA;
      cohortB.code = codeA;

      [[theValue([cohortB isEqual:cohortA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      cohortA.code = codeA;
      cohortB.code = codeA;

      [[theValue([cohortA isEqual:cohortB]) should] equal:theValue(YES)];

      cohortB.code = codeB;

      [[theValue([cohortA isEqual:cohortB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      cohortB.code = codeA;
      cohortB.code = codeB;

      [[theValue([cohortA isEqual:cohortB]) should] equal:theValue(NO)];

      cohortB.code = codeA;

      [[theValue([cohortA isEqual:cohortB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      cohortA.code = codeA;
      cohortB.code = codeA;

      [[theValue([cohortA hash]) should] equal:theValue([cohortB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      cohortA.code = codeA;
      cohortB.code = codeA;

      [[theValue([cohortA hash]) should] equal:theValue([cohortB hash])];

      cohortB.code = codeB;

      [[theValue([cohortA hash]) shouldNot] equal:theValue([cohortB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      cohortA.code = codeA;
      cohortB.code = codeB;

      [[theValue([cohortA hash]) shouldNot] equal:theValue([cohortB hash])];

      cohortB.code = codeA;

      [[theValue([cohortA hash]) should] equal:theValue([cohortB hash])];
    });
  });
});

SPEC_END
