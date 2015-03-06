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

#import "LUCampaignMetadata.h"
#import "LUCampaignMetadataJSONFactory.h"

SPEC_BEGIN(LUCampaignMetadataJSONFactorySpec)

describe(@"LUCampaignMetadataJSONFactory", ^{
  __block LUCampaignMetadataJSONFactory *factory;

  beforeEach(^{
    factory = [LUCampaignMetadataJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUCampaign", ^{
      NSDictionary *JSON = @{
        @"id": @1,
        @"representation_types": @[
          @"basic_v1"
        ]
      };
      LUCampaignMetadata *campaignMetadata = [factory createFromAttributes:JSON];

      [[campaignMetadata.campaignID should] equal:@1];
      [[campaignMetadata.representationTypes should] equal:@[@(LUCampaignRepresentationTypeBasicV1)]];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'campaign'", ^{
      [[[factory rootKey] should] equal:@"campaign"];
    });
  });
});

SPEC_END
