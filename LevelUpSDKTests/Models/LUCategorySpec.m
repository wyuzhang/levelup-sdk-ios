#import "LUCategory.h"

SPEC_BEGIN(LUCategorySpec)

describe(@"LUCategory", ^{
  LUCategory *categoryA = [[LUCategory alloc] init];
  LUCategory *categoryB = [[LUCategory alloc] init];
  NSString *nameA = @"catA";
  NSString *nameB = @"catB";

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      categoryA.name = nameA;
      categoryB.name = nameA;

      [[theValue([categoryA isEqual:categoryB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      categoryA.name = nameA;
      categoryB.name = nameA;

      [[theValue([categoryB isEqual:categoryA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      categoryA.name = nameA;
      categoryB.name = nameA;

      [[theValue([categoryA isEqual:categoryB]) should] equal:theValue(YES)];

      categoryB.name = nameB;

      [[theValue([categoryA isEqual:categoryB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      categoryB.name = nameA;
      categoryB.name = nameB;

      [[theValue([categoryA isEqual:categoryB]) should] equal:theValue(NO)];

      categoryB.name = nameA;

      [[theValue([categoryA isEqual:categoryB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      categoryA.name = nameA;
      categoryB.name = nameA;

      [[theValue([categoryA hash]) should] equal:theValue([categoryB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      categoryA.name = nameA;
      categoryB.name = nameA;

      [[theValue([categoryA hash]) should] equal:theValue([categoryB hash])];

      categoryB.name = nameB;

      [[theValue([categoryA hash]) shouldNot] equal:theValue([categoryB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      categoryA.name = nameA;
      categoryB.name = nameB;

      [[theValue([categoryA hash]) shouldNot] equal:theValue([categoryB hash])];

      categoryB.name = nameA;

      [[theValue([categoryA hash]) should] equal:theValue([categoryB hash])];
    });
  });
});

SPEC_END
