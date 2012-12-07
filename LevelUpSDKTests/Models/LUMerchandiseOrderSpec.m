#import "LUMerchandiseOrder.h"

SPEC_BEGIN(LUMerchandiseOrderSpec)

describe(@"LUMerchandiseOrder", ^{
  LUMerchandiseOrder *merchandiseOrderA = [[LUMerchandiseOrder alloc] init];
  LUMerchandiseOrder *merchandiseOrderB = [[LUMerchandiseOrder alloc] init];
  NSString *nameA = @"merchA";
  NSString *nameB = @"merchB";

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      merchandiseOrderA.firstName = nameA;
      merchandiseOrderB.firstName = nameA;

      [[theValue([merchandiseOrderA isEqual:merchandiseOrderB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      merchandiseOrderA.firstName = nameA;
      merchandiseOrderB.firstName = nameA;

      [[theValue([merchandiseOrderB isEqual:merchandiseOrderA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      merchandiseOrderA.firstName = nameA;
      merchandiseOrderB.firstName = nameA;

      [[theValue([merchandiseOrderA isEqual:merchandiseOrderB]) should] equal:theValue(YES)];

      merchandiseOrderB.firstName = nameB;

      [[theValue([merchandiseOrderA isEqual:merchandiseOrderB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      merchandiseOrderB.firstName = nameA;
      merchandiseOrderB.firstName = nameB;

      [[theValue([merchandiseOrderA isEqual:merchandiseOrderB]) should] equal:theValue(NO)];

      merchandiseOrderB.firstName = nameA;

      [[theValue([merchandiseOrderA isEqual:merchandiseOrderB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      merchandiseOrderA.firstName = nameA;
      merchandiseOrderB.firstName = nameA;

      [[theValue([merchandiseOrderA hash]) should] equal:theValue([merchandiseOrderB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      merchandiseOrderA.firstName = nameA;
      merchandiseOrderB.firstName = nameA;

      [[theValue([merchandiseOrderA hash]) should] equal:theValue([merchandiseOrderB hash])];

      merchandiseOrderB.firstName = nameB;

      [[theValue([merchandiseOrderA hash]) shouldNot] equal:theValue([merchandiseOrderB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      merchandiseOrderA.firstName = nameA;
      merchandiseOrderB.firstName = nameB;

      [[theValue([merchandiseOrderA hash]) shouldNot] equal:theValue([merchandiseOrderB hash])];

      merchandiseOrderB.firstName = nameA;

      [[theValue([merchandiseOrderA hash]) should] equal:theValue([merchandiseOrderB hash])];
    });
  });
});

SPEC_END
