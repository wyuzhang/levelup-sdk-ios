#import "LUApnDevice.h"

SPEC_BEGIN(LUApnDeviceSpec)

describe(@"LUApnDevice", ^{
  LUApnDevice *apnA = [[LUApnDevice alloc] init];
  LUApnDevice *apnB = [[LUApnDevice alloc] init];
  NSNumber *devA = [NSNumber numberWithInt:1];
  NSNumber *devB = [NSNumber numberWithInt:2];

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      apnA.development = devA;
      apnB.development = devA;

      [[theValue([apnA isEqual:apnB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      apnA.development = devA;
      apnB.development = devA;

      [[theValue([apnB isEqual:apnA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      apnA.development = devA;
      apnB.development = devA;

      [[theValue([apnA isEqual:apnB]) should] equal:theValue(YES)];

      apnB.development = devB;

      [[theValue([apnA isEqual:apnB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      apnB.development = devA;
      apnB.development = devB;

      [[theValue([apnA isEqual:apnB]) should] equal:theValue(NO)];

      apnB.development = devA;

      [[theValue([apnA isEqual:apnB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      apnA.development = devA;
      apnB.development = devA;

      [[theValue([apnA hash]) should] equal:theValue([apnB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      apnA.development = devA;
      apnB.development = devA;

      [[theValue([apnA hash]) should] equal:theValue([apnB hash])];

      apnB.development = devB;

      [[theValue([apnA hash]) shouldNot] equal:theValue([apnB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      apnA.development = devA;
      apnB.development = devB;

      [[theValue([apnA hash]) shouldNot] equal:theValue([apnB hash])];

      apnB.development = devA;

      [[theValue([apnA hash]) should] equal:theValue([apnB hash])];
    });
  });
});

SPEC_END
