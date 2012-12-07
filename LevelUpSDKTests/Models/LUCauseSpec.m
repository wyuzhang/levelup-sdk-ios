#import "LUCause.h"

SPEC_BEGIN(LUCauseSpec)

describe(@"LUCause", ^{
  LUCause *causeA = [[LUCause alloc] init];
  LUCause *causeB = [[LUCause alloc] init];
  NSString *nameA = @"causeA";
  NSString *nameB = @"causeB";

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      causeA.name = nameA;
      causeB.name = nameA;

      [[theValue([causeA isEqual:causeB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      causeA.name = nameA;
      causeB.name = nameA;

      [[theValue([causeB isEqual:causeA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      causeA.name = nameA;
      causeB.name = nameA;

      [[theValue([causeA isEqual:causeB]) should] equal:theValue(YES)];

      causeB.name = nameB;

      [[theValue([causeA isEqual:causeB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      causeB.name = nameA;
      causeB.name = nameB;

      [[theValue([causeA isEqual:causeB]) should] equal:theValue(NO)];

      causeB.name = nameA;

      [[theValue([causeA isEqual:causeB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      causeA.name = nameA;
      causeB.name = nameA;

      [[theValue([causeA hash]) should] equal:theValue([causeB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      causeA.name = nameA;
      causeB.name = nameA;

      [[theValue([causeA hash]) should] equal:theValue([causeB hash])];

      causeB.name = nameB;

      [[theValue([causeA hash]) shouldNot] equal:theValue([causeB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      causeA.name = nameA;
      causeB.name = nameB;

      [[theValue([causeA hash]) shouldNot] equal:theValue([causeB hash])];

      causeB.name = nameA;

      [[theValue([causeA hash]) should] equal:theValue([causeB hash])];
    });
  });
});

SPEC_END
