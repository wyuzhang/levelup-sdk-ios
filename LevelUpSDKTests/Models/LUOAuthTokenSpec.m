#import "LUOAuthToken.h"

SPEC_BEGIN(LUOAuthTokenSpec)

describe(@"LUOAuthToken", ^{
  LUOAuthToken *oAuthTokenA = [[LUOAuthToken alloc] init];
  LUOAuthToken *oAuthTokenB = [[LUOAuthToken alloc] init];
  NSString *clientA = @"clientA";
  NSString *clientB = @"clientB";

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      oAuthTokenA.clientId = clientA;
      oAuthTokenB.clientId = clientA;

      [[theValue([oAuthTokenA isEqual:oAuthTokenB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      oAuthTokenA.clientId = clientA;
      oAuthTokenB.clientId = clientA;

      [[theValue([oAuthTokenB isEqual:oAuthTokenA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      oAuthTokenA.clientId = clientA;
      oAuthTokenB.clientId = clientA;

      [[theValue([oAuthTokenA isEqual:oAuthTokenB]) should] equal:theValue(YES)];

      oAuthTokenB.clientId = clientB;

      [[theValue([oAuthTokenA isEqual:oAuthTokenB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      oAuthTokenB.clientId = clientA;
      oAuthTokenB.clientId = clientB;

      [[theValue([oAuthTokenA isEqual:oAuthTokenB]) should] equal:theValue(NO)];

      oAuthTokenB.clientId = clientA;

      [[theValue([oAuthTokenA isEqual:oAuthTokenB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      oAuthTokenA.clientId = clientA;
      oAuthTokenB.clientId = clientA;

      [[theValue([oAuthTokenA hash]) should] equal:theValue([oAuthTokenB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      oAuthTokenA.clientId = clientA;
      oAuthTokenB.clientId = clientA;

      [[theValue([oAuthTokenA hash]) should] equal:theValue([oAuthTokenB hash])];

      oAuthTokenB.clientId = clientB;

      [[theValue([oAuthTokenA hash]) shouldNot] equal:theValue([oAuthTokenB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      oAuthTokenA.clientId = clientA;
      oAuthTokenB.clientId = clientB;

      [[theValue([oAuthTokenA hash]) shouldNot] equal:theValue([oAuthTokenB hash])];

      oAuthTokenB.clientId = clientA;

      [[theValue([oAuthTokenA hash]) should] equal:theValue([oAuthTokenB hash])];
    });
  });
});

SPEC_END
