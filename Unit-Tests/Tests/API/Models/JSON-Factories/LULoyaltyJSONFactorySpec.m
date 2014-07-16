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

#import "LULoyaltyJSONFactory.h"

SPEC_BEGIN(LULoyaltyJSONFactorySpec)

describe(@"LULoyaltyJSONFactory", ^{
  __block LULoyaltyJSONFactory *factory;

  beforeAll(^{
    factory = [LULoyaltyJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LULoyalty", ^{
      NSDictionary *JSON = @{
        @"merchant_earn_amount" : @500,
        @"merchant_id" : @456,
        @"merchant_loyalty_enabled" : @YES,
        @"merchant_spend_amount" : @5000,
        @"orders_count" : @77,
        @"potential_credit_amount" : @7350.11,
        @"progress_percentage" : @42.0,
        @"savings_amount" : @835,
        @"spend_remaining_amount" : @427,
        @"total_volume_amount" : @6317,
        @"user_id" : @789
      };
      LULoyalty *loyalty = [factory createFromAttributes:JSON];

      [[loyalty should] beKindOfClass:[LULoyalty class]];
      [[loyalty.willEarn should] equal:[LUMonetaryValue monetaryValueWithUSCents:@500]];
      [[loyalty.merchantID should] equal:@456];
      [[theValue(loyalty.merchantLoyaltyEnabled) should] beYes];
      [[loyalty.shouldSpend should] equal:[LUMonetaryValue monetaryValueWithUSCents:@5000]];
      [[loyalty.ordersCount should] equal:@77];
      [[loyalty.potentialCredit should] equal:[LUMonetaryValue monetaryValueWithUSCents:@7350.11]];
      [[theValue(loyalty.progressPercent) should] equal:theValue(0.42f)];
      [[loyalty.savings should] equal:[LUMonetaryValue monetaryValueWithUSCents:@835]];
      [[loyalty.spendRemaining should] equal:[LUMonetaryValue monetaryValueWithUSCents:@427]];
      [[loyalty.totalVolume should] equal:[LUMonetaryValue monetaryValueWithUSCents:@6317]];
    });
  });

  describe(@"rootKey", ^{
    it(@"returns 'loyalty'", ^{
      [[[factory rootKey] should] equal:@"loyalty"];
    });
  });
});

SPEC_END
