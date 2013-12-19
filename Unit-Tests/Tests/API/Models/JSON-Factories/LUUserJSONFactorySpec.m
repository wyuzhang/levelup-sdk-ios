// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUUserJSONFactory.h"
#import "NSDate+StringFormats.h"

SPEC_BEGIN(LUUserJSONFactorySpec)

describe(@"LUUserJSONFactory", ^{
  __block LUUserJSONFactory *factory;

  beforeEach(^{
    factory = [LUUserJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUUser", ^{
      NSDictionary *JSON = @{
        @"born_at" : @"2012-12-04T18:10:45-05:00",
        @"cause_id" : @1,
        @"connected_to_facebook" : @YES,
        @"custom_attributes" : @{@"key" : @"value"},
        @"email" : @"test@example.com",
        @"first_name" : @"Test",
        @"gender" : @"male",
        @"global_credit_amount" : @100,
        @"id" : @1,
        @"last_name" : @"User",
        @"merchants_visited_count" : @5,
        @"orders_count" : @10,
        @"terms_accepted_at" : @"2012-12-04T18:10:45-05:00",
        @"total_savings_amount" : @200
      };
      LUUser *user = [factory createFromAttributes:JSON];

      [[user.birthdate should] equal:[NSDate lu_dateFromIso8601DateTimeString:@"2012-12-04T18:10:45-05:00"]];
      [[user.causeID should] equal:@1];
      [[theValue(user.connectedToFacebook) should] beYes];
      [[user.customAttributes should] equal:@{@"key" : @"value"}];
      [[user.email should] equal:@"test@example.com"];
      [[user.firstName should] equal:@"Test"];
      [[theValue(user.gender) should] equal:theValue(LUGenderMale)];
      [[user.globalCredit should] equal:[LUMonetaryValue monetaryValueWithUSCents:@100]];
      [[user.lastName should] equal:@"User"];
      [[user.merchantsVisitedCount should] equal:@5];
      [[user.ordersCount should] equal:@10];
      [[theValue(user.termsAccepted) should] beYes];
      [[user.totalSavings should] equal:[LUMonetaryValue monetaryValueWithUSCents:@200]];
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
