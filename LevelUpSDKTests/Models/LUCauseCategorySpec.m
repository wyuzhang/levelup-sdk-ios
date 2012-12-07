#import "LUCauseCategory.h"

SPEC_BEGIN(LUCauseCategorySpec)

describe(@"LUCauseCategory", ^{
  LUCauseCategory *causeCategoryA = [[LUCauseCategory alloc] init];
  LUCauseCategory *causeCategoryB = [[LUCauseCategory alloc] init];
  NSString *nameA = @"ccA";
  NSString *nameB = @"ccB";

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      causeCategoryA.name = nameA;
      causeCategoryB.name = nameA;

      [[theValue([causeCategoryA isEqual:causeCategoryB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      causeCategoryA.name = nameA;
      causeCategoryB.name = nameA;

      [[theValue([causeCategoryB isEqual:causeCategoryA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      causeCategoryA.name = nameA;
      causeCategoryB.name = nameA;

      [[theValue([causeCategoryA isEqual:causeCategoryB]) should] equal:theValue(YES)];

      causeCategoryB.name = nameB;

      [[theValue([causeCategoryA isEqual:causeCategoryB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      causeCategoryB.name = nameA;
      causeCategoryB.name = nameB;

      [[theValue([causeCategoryA isEqual:causeCategoryB]) should] equal:theValue(NO)];

      causeCategoryB.name = nameA;

      [[theValue([causeCategoryA isEqual:causeCategoryB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      causeCategoryA.name = nameA;
      causeCategoryB.name = nameA;

      [[theValue([causeCategoryA hash]) should] equal:theValue([causeCategoryB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      causeCategoryA.name = nameA;
      causeCategoryB.name = nameA;

      [[theValue([causeCategoryA hash]) should] equal:theValue([causeCategoryB hash])];

      causeCategoryB.name = nameB;

      [[theValue([causeCategoryA hash]) shouldNot] equal:theValue([causeCategoryB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      causeCategoryA.name = nameA;
      causeCategoryB.name = nameB;

      [[theValue([causeCategoryA hash]) shouldNot] equal:theValue([causeCategoryB hash])];

      causeCategoryB.name = nameA;

      [[theValue([causeCategoryA hash]) should] equal:theValue([causeCategoryB hash])];
    });
  });
});

SPEC_END
