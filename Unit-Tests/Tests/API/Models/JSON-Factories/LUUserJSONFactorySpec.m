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

      [[theValue(user.ableToRefer) should] beYes];
      [[user.birthdate should] equal:[NSDate fixture]];
      [[theValue(user.connectedToFacebook) should] beYes];
      [[user.credit should] equal:[LUMonetaryValue fullMonetaryValue]];
      [[user.customAttributes should] equal:@{@"key" : @"value"}];
      [[user.email should] equal:@"test@example.com"];
      [[user.employer should] equal:@"SCVNGR"];
      [[user.firstName should] equal:@"Test"];
      [[theValue(user.gender) should] equal:theValue(LUGenderMale)];
      [[user.lastName should] equal:@"User"];
      [[user.loyaltiesSavings should] equal:[LUMonetaryValue fullMonetaryValue]];
      [[user.merchantsVisitedCount should] equal:@5];
      [[user.ordersCount should] equal:@10];
      [[theValue(user.paymentEligible) should] beYes];
      [[user.paymentToken should] equal:@"payment-token"];
      [[user.termsAcceptedDate should] equal:[NSDate fixture]];
      [[user.userAddresses should] equal:@[[LUUserAddress fullUserAddress]]];
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
