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

#import "LURewardSummaryJSONFactory.h"

SPEC_BEGIN(LURewardSummaryJSONFactorySpec)

describe(@"LURewardSummaryJSONFactory", ^{
  __block LURewardSummaryJSONFactory *factory;

  beforeEach(^{
    factory = [LURewardSummaryJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LURewardSummary", ^{
      NSDictionary *JSON = @{
        @"credit_amount": @200,
        @"reward_count": @2,
        @"usable_as_credit_reward_count": @1
      };
      LURewardSummary *rewardSummary = [factory createFromAttributes:JSON];

      [[rewardSummary.credit should] equal:[LUMonetaryValue monetaryValueWithUSCents:@200]];
      [[theValue(rewardSummary.rewardCount) should] equal:theValue(2)];
      [[theValue(rewardSummary.usableAsCreditRewardCount) should] equal:theValue(1)];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'reward_summary'", ^{
      [[[factory rootKey] should] equal:@"reward_summary"];
    });
  });
});

SPEC_END
