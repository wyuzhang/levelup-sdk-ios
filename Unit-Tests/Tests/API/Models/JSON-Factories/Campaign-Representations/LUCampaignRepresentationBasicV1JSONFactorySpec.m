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

#import "LUCampaignRepresentationBasicV1JSONFactory.h"

SPEC_BEGIN(LUCampaignRepresentationBasicV1JSONFactorySpec)

describe(@"LUCampaignRepresentationBasicV1JSONFactory", ^{
  __block LUCampaignRepresentationBasicV1JSONFactory *factory;

  beforeEach(^{
    factory = [LUCampaignRepresentationBasicV1JSONFactory factoryWithCampaignID:@1];
  });

  it(@"is an LUBaseCampaignRepresentationJSONFactory", ^{
    [[[LUCampaignRepresentationBasicV1JSONFactory class] should] beSubclassOfClass:[LUBaseCampaignRepresentationJSONFactory class]];
  });

  // Public Methods

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUCampaignRepresentationBasicV1", ^{
      NSDictionary *JSON = @{
        @"description": @"description",
        @"title": @"title"
      };
      LUCampaignRepresentationBasicV1 *campaign = [factory createFromAttributes:JSON];

      [[campaign.campaignID should] equal:@1];
      [[campaign.campaignDescription should] equal:@"description"];
      [[campaign.title should] equal:@"title"];
    });
  });
});

SPEC_END
