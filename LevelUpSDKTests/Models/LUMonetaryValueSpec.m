#import "LUMonetaryValue.h"

SPEC_BEGIN(LUMonetaryValueSpec)

describe(@"LUMonetaryValue", ^{
  LUMonetaryValue *monetaryValueA = [[LUMonetaryValue alloc] init];
  LUMonetaryValue *monetaryValueB = [[LUMonetaryValue alloc] init];
  NSNumber *valA = [NSNumber numberWithInt:1];
  NSNumber *valB = [NSNumber numberWithInt:2];

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      monetaryValueA.amount = valA;
      monetaryValueB.amount = valA;

      [[theValue([monetaryValueA isEqual:monetaryValueB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      monetaryValueA.amount = valA;
      monetaryValueB.amount = valA;

      [[theValue([monetaryValueB isEqual:monetaryValueA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      monetaryValueA.amount = valA;
      monetaryValueB.amount = valA;

      [[theValue([monetaryValueA isEqual:monetaryValueB]) should] equal:theValue(YES)];

      monetaryValueB.amount = valB;

      [[theValue([monetaryValueA isEqual:monetaryValueB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      monetaryValueB.amount = valA;
      monetaryValueB.amount = valB;

      [[theValue([monetaryValueA isEqual:monetaryValueB]) should] equal:theValue(NO)];

      monetaryValueB.amount = valA;

      [[theValue([monetaryValueA isEqual:monetaryValueB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      monetaryValueA.amount = valA;
      monetaryValueB.amount = valA;

      [[theValue([monetaryValueA hash]) should] equal:theValue([monetaryValueB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      monetaryValueA.amount = valA;
      monetaryValueB.amount = valA;

      [[theValue([monetaryValueA hash]) should] equal:theValue([monetaryValueB hash])];

      monetaryValueB.amount = valB;

      [[theValue([monetaryValueA hash]) shouldNot] equal:theValue([monetaryValueB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      monetaryValueA.amount = valA;
      monetaryValueB.amount = valB;

      [[theValue([monetaryValueA hash]) shouldNot] equal:theValue([monetaryValueB hash])];

      monetaryValueB.amount = valA;

      [[theValue([monetaryValueA hash]) should] equal:theValue([monetaryValueB hash])];
    });
  });
});

SPEC_END
