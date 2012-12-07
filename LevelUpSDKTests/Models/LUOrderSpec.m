#import "LUOrder.h"

SPEC_BEGIN(LUOrderSpec)

describe(@"LUOrder", ^{
  LUOrder *orderA = [[LUOrder alloc] init];
  LUOrder *orderB = [[LUOrder alloc] init];
  NSString *codeA = @"12345";
  NSString *codeB = @"54321";

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      orderA.code = codeA;
      orderB.code = codeA;

      [[theValue([orderA isEqual:orderB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      orderA.code = codeA;
      orderB.code = codeA;

      [[theValue([orderB isEqual:orderA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      orderA.code = codeA;
      orderB.code = codeA;

      [[theValue([orderA isEqual:orderB]) should] equal:theValue(YES)];

      orderB.code = codeB;

      [[theValue([orderA isEqual:orderB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      orderB.code = codeA;
      orderB.code = codeB;

      [[theValue([orderA isEqual:orderB]) should] equal:theValue(NO)];

      orderB.code = codeA;

      [[theValue([orderA isEqual:orderB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      orderA.code = codeA;
      orderB.code = codeA;

      [[theValue([orderA hash]) should] equal:theValue([orderB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      orderA.code = codeA;
      orderB.code = codeA;

      [[theValue([orderA hash]) should] equal:theValue([orderB hash])];

      orderB.code = codeB;

      [[theValue([orderA hash]) shouldNot] equal:theValue([orderB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      orderA.code = codeA;
      orderB.code = codeB;

      [[theValue([orderA hash]) shouldNot] equal:theValue([orderB hash])];

      orderB.code = codeA;

      [[theValue([orderA hash]) should] equal:theValue([orderB hash])];
    });
  });
});

SPEC_END
