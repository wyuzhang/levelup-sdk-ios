#import "LUUserJSONFactory.h"

SPEC_BEGIN(LUUserJSONFactorySpec)

describe(@"LUUserJSONFactory", ^{
  __block LUUserJSONFactory *factory;

  beforeEach(^{
    factory = [LUUserJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUUser", ^{
      LUUser *user = [factory createFromAttributes:[LUUser fullJSONObject]];

      [[user.birthdate should] equal:[NSDate fixture]];
      [[user.causeID should] equal:@1];
      [[theValue(user.connectedToFacebook) should] beYes];
      [[user.customAttributes should] equal:@{@"key" : @"value"}];
      [[user.email should] equal:@"test@example.com"];
      [[user.firstName should] equal:@"Test"];
      [[theValue(user.gender) should] equal:theValue(LUGenderMale)];
      [[user.globalCredit should] equal:[LUMonetaryValue fullMonetaryValue]];
      [[user.lastName should] equal:@"User"];
      [[user.merchantsVisitedCount should] equal:@5];
      [[user.ordersCount should] equal:@10];
      [[user.termsAcceptedDate should] equal:[NSDate fixture]];
      [[user.totalSavings should] equal:[LUMonetaryValue fullMonetaryValue]];
      [[user.userID should] equal:@1];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'user'", ^{
      [[[factory rootKey] should] equal:@"user"];
    });
  });
});

SPEC_END
