#import "LUDivision.h"

SPEC_BEGIN(LUDivisionSpec)

describe(@"LUDivision", ^{
  LUDivision *divisionA = [[LUDivision alloc] init];
  LUDivision *divisionB = [[LUDivision alloc] init];
  NSString *nameA = @"divA";
  NSString *nameB = @"divB";

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      divisionA.name = nameA;
      divisionB.name = nameA;

      [[theValue([divisionA isEqual:divisionB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      divisionA.name = nameA;
      divisionB.name = nameA;

      [[theValue([divisionB isEqual:divisionA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      divisionA.name = nameA;
      divisionB.name = nameA;

      [[theValue([divisionA isEqual:divisionB]) should] equal:theValue(YES)];

      divisionB.name = nameB;

      [[theValue([divisionA isEqual:divisionB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      divisionB.name = nameA;
      divisionB.name = nameB;

      [[theValue([divisionA isEqual:divisionB]) should] equal:theValue(NO)];

      divisionB.name = nameA;

      [[theValue([divisionA isEqual:divisionB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      divisionA.name = nameA;
      divisionB.name = nameA;

      [[theValue([divisionA hash]) should] equal:theValue([divisionB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      divisionA.name = nameA;
      divisionB.name = nameA;

      [[theValue([divisionA hash]) should] equal:theValue([divisionB hash])];

      divisionB.name = nameB;

      [[theValue([divisionA hash]) shouldNot] equal:theValue([divisionB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      divisionA.name = nameA;
      divisionB.name = nameB;

      [[theValue([divisionA hash]) shouldNot] equal:theValue([divisionB hash])];

      divisionB.name = nameA;

      [[theValue([divisionA hash]) should] equal:theValue([divisionB hash])];
    });
  });
});

SPEC_END
