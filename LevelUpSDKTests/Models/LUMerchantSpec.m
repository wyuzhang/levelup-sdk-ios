#import "LUMerchant.h"

SPEC_BEGIN(LUMerchantSpec)

describe(@"LUMerchant", ^{
  LUMerchant *merchantA = [[LUMerchant alloc] init];
  LUMerchant *merchantB = [[LUMerchant alloc] init];
  NSString *nameA = @"merchA";
  NSString *nameB = @"merchB";

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      merchantA.name = nameA;
      merchantB.name = nameA;

      [[theValue([merchantA isEqual:merchantB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      merchantA.name = nameA;
      merchantB.name = nameA;

      [[theValue([merchantB isEqual:merchantA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      merchantA.name = nameA;
      merchantB.name = nameA;

      [[theValue([merchantA isEqual:merchantB]) should] equal:theValue(YES)];

      merchantB.name = nameB;

      [[theValue([merchantA isEqual:merchantB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      merchantB.name = nameA;
      merchantB.name = nameB;

      [[theValue([merchantA isEqual:merchantB]) should] equal:theValue(NO)];

      merchantB.name = nameA;

      [[theValue([merchantA isEqual:merchantB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      merchantA.name = nameA;
      merchantB.name = nameA;

      [[theValue([merchantA hash]) should] equal:theValue([merchantB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      merchantA.name = nameA;
      merchantB.name = nameA;

      [[theValue([merchantA hash]) should] equal:theValue([merchantB hash])];

      merchantB.name = nameB;

      [[theValue([merchantA hash]) shouldNot] equal:theValue([merchantB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      merchantA.name = nameA;
      merchantB.name = nameB;

      [[theValue([merchantA hash]) shouldNot] equal:theValue([merchantB hash])];

      merchantB.name = nameA;

      [[theValue([merchantA hash]) should] equal:theValue([merchantB hash])];
    });
  });
});

SPEC_END
