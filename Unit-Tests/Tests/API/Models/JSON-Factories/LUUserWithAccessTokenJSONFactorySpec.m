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

#import "LUAccessToken.h"
#import "LUAccessTokenJSONFactory.h"
#import "LUUser.h"
#import "LUUserJSONFactory.h"
#import "LUUserWithAccessToken.h"
#import "LUUserWithAccessTokenJSONFactory.h"

SPEC_BEGIN(LUUserWithAccessTokenJSONFactorySpec)

describe(@"LUUserWithAccessTokenJSONFactory", ^{
  __block LUUserWithAccessTokenJSONFactory *factory;

  beforeEach(^{
    factory = [LUUserWithAccessTokenJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUUserWithAccessToken", ^{
      NSDictionary *JSON = @{
        @"access_token": @{
          @"token": @"abc123"
        },
        @"user": @{
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
        }
      };

      LUUserWithAccessToken *userWithAccessToken = [factory createFromAttributes:JSON];

      LUAccessToken *accessToken = [[LUAccessTokenJSONFactory factory] fromJSONObject:JSON[@"access_token"]];
      [[userWithAccessToken.accessToken should] equal:accessToken];

      LUUser *user = [[LUUserJSONFactory factory] fromJSONObject:JSON[@"user"]];
      [[userWithAccessToken.user should] equal:user];
    });
  });

  describe(@"rootKey", ^{
    it(@"is nil", ^{
      [[[factory rootKey] should] beNil];
    });
  });
});

SPEC_END
