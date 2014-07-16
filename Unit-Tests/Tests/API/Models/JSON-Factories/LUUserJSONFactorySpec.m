/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
        @"debit_card_only" : @YES,
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
      [[[user valueForKey:@"connectedToFacebook"] should] beYes];
      [[user.customAttributes should] equal:@{@"key" : @"value"}];
      [[[user valueForKey:@"debitCardOnly"] should] beYes];
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
