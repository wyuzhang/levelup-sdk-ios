#import "LULoyalty.h"

SPEC_BEGIN(LULoyaltySpec)

describe(@"LULoyalty", ^{
  LULoyalty *loyaltyA = [[LULoyalty alloc] init];
  LULoyalty *loyaltyB = [[LULoyalty alloc] init];
  NSNumber *progressPercentA = [NSNumber numberWithInt:30];
  NSNumber *progressPercentB = [NSNumber numberWithInt:50];

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      loyaltyA.progressPercent = progressPercentA;
      loyaltyB.progressPercent = progressPercentA;

      [[theValue([loyaltyA isEqual:loyaltyB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      loyaltyA.progressPercent = progressPercentA;
      loyaltyB.progressPercent = progressPercentA;

      [[theValue([loyaltyB isEqual:loyaltyA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      loyaltyA.progressPercent = progressPercentA;
      loyaltyB.progressPercent = progressPercentA;

      [[theValue([loyaltyA isEqual:loyaltyB]) should] equal:theValue(YES)];

      loyaltyB.progressPercent = progressPercentB;

      [[theValue([loyaltyA isEqual:loyaltyB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      loyaltyB.progressPercent = progressPercentA;
      loyaltyB.progressPercent = progressPercentB;

      [[theValue([loyaltyA isEqual:loyaltyB]) should] equal:theValue(NO)];

      loyaltyB.progressPercent = progressPercentA;

      [[theValue([loyaltyA isEqual:loyaltyB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      loyaltyA.progressPercent = progressPercentA;
      loyaltyB.progressPercent = progressPercentA;

      [[theValue([loyaltyA hash]) should] equal:theValue([loyaltyB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      loyaltyA.progressPercent = progressPercentA;
      loyaltyB.progressPercent = progressPercentA;

      [[theValue([loyaltyA hash]) should] equal:theValue([loyaltyB hash])];

      loyaltyB.progressPercent = progressPercentB;

      [[theValue([loyaltyA hash]) shouldNot] equal:theValue([loyaltyB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      loyaltyA.progressPercent = progressPercentA;
      loyaltyB.progressPercent = progressPercentB;

      [[theValue([loyaltyA hash]) shouldNot] equal:theValue([loyaltyB hash])];

      loyaltyB.progressPercent = progressPercentA;

      [[theValue([loyaltyA hash]) should] equal:theValue([loyaltyB hash])];
    });
  });
});

SPEC_END
