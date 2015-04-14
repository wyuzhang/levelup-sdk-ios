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

#import "LUCampaignRepresentationSpendBasedLoyaltyV1JSONFactory.h"

SPEC_BEGIN(LUCampaignRepresentationSpendBasedLoyaltyV1JSONFactorySpec)

describe(@"LUCampaignRepresentationSpendBasedLoyaltyV1JSONFactory", ^{
  __block LUCampaignRepresentationSpendBasedLoyaltyV1JSONFactory *factory;

  beforeEach(^{
    factory = [LUCampaignRepresentationSpendBasedLoyaltyV1JSONFactory factoryWithCampaignID:@1];
  });

  it(@"is an LUBaseCampaignRepresentationJSONFactory", ^{
    [[[LUCampaignRepresentationSpendBasedLoyaltyV1JSONFactory class] should] beSubclassOfClass:[LUBaseCampaignRepresentationJSONFactory class]];
  });

  // Public Methods

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUCampaignRepresentationSpendBasedLoyaltyV1", ^{
      NSDictionary *JSON = @{
        @"earn_amount": @500,
        @"progress_amount": @200,
        @"required_spend_amount": @5000
      };
      LUCampaignRepresentationSpendBasedLoyaltyV1 *campaign = [factory createFromAttributes:JSON];

      [[campaign.campaignID should] equal:@1];
      [[campaign.earn should] equal:[LUMonetaryValue monetaryValueWithUSCents:@500]];
      [[campaign.progress should] equal:[LUMonetaryValue monetaryValueWithUSCents:@200]];
      [[campaign.requiredSpend should] equal:[LUMonetaryValue monetaryValueWithUSCents:@5000]];
    });
  });
});

SPEC_END
