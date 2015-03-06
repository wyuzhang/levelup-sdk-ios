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

SPEC_BEGIN(LUCampaignMetadataSpec)

describe(@"LUCampaignMetadata", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUCampaignMetadata class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Public Methods

  describe(@"campaignRepresentationTypeForString:", ^{
    it(@"returns the campaign representation type for the given string", ^{
      [[theValue([LUCampaignMetadata campaignRepresentationTypeForString:@"basic_v1"]) should] equal:theValue(LUCampaignRepresentationTypeBasicV1)];
    });
  });

  describe(@"stringForCampaignRepresentationType:", ^{
    it(@"returns the string for the campaign representation type", ^{
      [[[LUCampaignMetadata stringForCampaignRepresentationType:LUCampaignRepresentationTypeBasicV1] should] equal:@"basic_v1"];
    });
  });
});

SPEC_END
