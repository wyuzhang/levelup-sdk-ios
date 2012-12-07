#import "LUTicket.h"

SPEC_BEGIN(LUTicketSpec)

describe(@"LUTicket", ^{
  LUTicket *ticketA = [[LUTicket alloc] init];
  LUTicket *ticketB = [[LUTicket alloc] init];
  NSString *bodyA = @"12345";
  NSString *bodyB = @"54321";

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      ticketA.body = bodyA;
      ticketB.body = bodyA;

      [[theValue([ticketA isEqual:ticketB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      ticketA.body = bodyA;
      ticketB.body = bodyA;

      [[theValue([ticketB isEqual:ticketA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      ticketA.body = bodyA;
      ticketB.body = bodyA;

      [[theValue([ticketA isEqual:ticketB]) should] equal:theValue(YES)];

      ticketB.body = bodyB;

      [[theValue([ticketA isEqual:ticketB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      ticketB.body = bodyA;
      ticketB.body = bodyB;

      [[theValue([ticketA isEqual:ticketB]) should] equal:theValue(NO)];

      ticketB.body = bodyA;

      [[theValue([ticketA isEqual:ticketB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      ticketA.body = bodyA;
      ticketB.body = bodyA;

      [[theValue([ticketA hash]) should] equal:theValue([ticketB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      ticketA.body = bodyA;
      ticketB.body = bodyA;

      [[theValue([ticketA hash]) should] equal:theValue([ticketB hash])];

      ticketB.body = bodyB;

      [[theValue([ticketA hash]) shouldNot] equal:theValue([ticketB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      ticketA.body = bodyA;
      ticketB.body = bodyB;

      [[theValue([ticketA hash]) shouldNot] equal:theValue([ticketB hash])];

      ticketB.body = bodyA;

      [[theValue([ticketA hash]) should] equal:theValue([ticketB hash])];
    });
  });
});

SPEC_END
