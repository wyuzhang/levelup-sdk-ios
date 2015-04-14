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

#import "LUCampaignRepresentationVisitBasedLoyaltyV1JSONFactory.h"

SPEC_BEGIN(LUCampaignRepresentationVisitBasedLoyaltyV1JSONFactorySpec)

describe(@"LUCampaignRepresentationVisitBasedLoyaltyV1JSONFactory", ^{
  __block LUCampaignRepresentationVisitBasedLoyaltyV1JSONFactory *factory;

  beforeEach(^{
    factory = [LUCampaignRepresentationVisitBasedLoyaltyV1JSONFactory factoryWithCampaignID:@1];
  });

  it(@"is an LUBaseCampaignRepresentationJSONFactory", ^{
    [[[LUCampaignRepresentationVisitBasedLoyaltyV1JSONFactory class] should] beSubclassOfClass:[LUBaseCampaignRepresentationJSONFactory class]];
  });

  // Public Methods

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUCampaignRepresentationVisitBasedLoyaltyV1", ^{
      NSDictionary *JSON = @{
        @"earn_amount": @1000,
        @"progress_visit_count": @5,
        @"qualifying_order_spend_amount": @50,
        @"required_visit_count": @10
      };
      LUCampaignRepresentationVisitBasedLoyaltyV1 *campaign = [factory createFromAttributes:JSON];

      [[campaign.campaignID should] equal:@1];
      [[campaign.earn should] equal:[LUMonetaryValue monetaryValueWithUSCents:@1000]];
      [[theValue(campaign.progressVisitCount) should] equal:theValue(5)];
      [[campaign.qualifyingOrderSpend should] equal:[LUMonetaryValue monetaryValueWithUSCents:@50]];
      [[theValue(campaign.requiredVisitCount) should] equal:theValue(10)];
    });
  });
});

SPEC_END
