#import "LUCreditCard.h"

SPEC_BEGIN(LUCreditCardSpec)

describe(@"LUCreditCard", ^{
  LUCreditCard *creditCardA = [[LUCreditCard alloc] init];
  LUCreditCard *creditCardB = [[LUCreditCard alloc] init];
  NSString *last4A = @"1234";
  NSString *last4B = @"2345";

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      creditCardA.last_4 = last4A;
      creditCardB.last_4 = last4A;

      [[theValue([creditCardA isEqual:creditCardB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      creditCardA.last_4 = last4A;
      creditCardB.last_4 = last4A;

      [[theValue([creditCardB isEqual:creditCardA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      creditCardA.last_4 = last4A;
      creditCardB.last_4 = last4A;

      [[theValue([creditCardA isEqual:creditCardB]) should] equal:theValue(YES)];

      creditCardB.last_4 = last4B;

      [[theValue([creditCardA isEqual:creditCardB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      creditCardB.last_4 = last4A;
      creditCardB.last_4 = last4B;

      [[theValue([creditCardA isEqual:creditCardB]) should] equal:theValue(NO)];

      creditCardB.last_4 = last4A;

      [[theValue([creditCardA isEqual:creditCardB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      creditCardA.last_4 = last4A;
      creditCardB.last_4 = last4A;

      [[theValue([creditCardA hash]) should] equal:theValue([creditCardB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      creditCardA.last_4 = last4A;
      creditCardB.last_4 = last4A;

      [[theValue([creditCardA hash]) should] equal:theValue([creditCardB hash])];

      creditCardB.last_4 = last4B;

      [[theValue([creditCardA hash]) shouldNot] equal:theValue([creditCardB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      creditCardA.last_4 = last4A;
      creditCardB.last_4 = last4B;

      [[theValue([creditCardA hash]) shouldNot] equal:theValue([creditCardB hash])];

      creditCardB.last_4 = last4A;

      [[theValue([creditCardA hash]) should] equal:theValue([creditCardB hash])];
    });
  });
});

SPEC_END
