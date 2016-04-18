/*
 * Copyright (C) 2015 SCVNGR, Inc. d/b/a LevelUp
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

#import "LURewardJSONFactory.h"
#import "NSDate+StringFormats.h"

SPEC_BEGIN(LURewardJSONFactorySpec)

describe(@"LURewardJSONFactory", ^{
  __block LURewardJSONFactory *factory;

  beforeEach(^{
    factory = [LURewardJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUReward", ^{
      NSDictionary *JSON = @{
        @"created_at": @"2012-12-04T18:10:45-05:00",
        @"description": @"$2 Onboarding credit",
        @"expires_at": @"2012-12-04T18:10:45-05:00",
        @"id": @"campaign-1",
        @"source_campaign_id": @1,
        @"tags": @[@"custom", @"merchant_funded"],
        @"title": @"Onboarding",
        @"usable": @YES,
        @"usable_as_credit": @YES,
        @"usable_now": @YES,
        @"value_remaining_amount": @200
      };
      LUReward *reward = [factory createFromAttributes:JSON];

      [[reward.createdAtDate should] equal:[NSDate lu_dateFromIso8601DateTimeString:@"2012-12-04T18:10:45-05:00"]];
      [[reward.expiresAtDate should] equal:[NSDate lu_dateFromIso8601DateTimeString:@"2012-12-04T18:10:45-05:00"]];
      [[reward.rewardDescription should] equal:@"$2 Onboarding credit"];
      [[reward.rewardID should] equal:@"campaign-1"];
      [[reward.sourceCampaignID should] equal:@1];
      [[reward.tags should] equal:@[@"custom", @"merchant_funded"]];
      [[reward.title should] equal:@"Onboarding"];
      [[theValue(reward.usable) should] beYes];
      [[theValue(reward.usableAsCredit) should] beYes];
      [[theValue(reward.usableNow) should] beYes];
      [[reward.valueRemaining should] equal:[LUMonetaryValue monetaryValueWithUSCents:@200]];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'reward'", ^{
      [[[factory rootKey] should] equal:@"reward"];
    });
  });
});

SPEC_END
