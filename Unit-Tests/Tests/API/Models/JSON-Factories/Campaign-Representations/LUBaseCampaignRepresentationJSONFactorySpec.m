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

#import "LUBaseCampaignRepresentationJSONFactory.h"

SPEC_BEGIN(LUBaseCampaignRepresentationJSONFactorySpec)

describe(@"LUBaseCampaignRepresentationJSONFactory", ^{
  NSNumber *campaignID = @1;
  __block LUBaseCampaignRepresentationJSONFactory *factory;

  beforeEach(^{
    factory = [LUBaseCampaignRepresentationJSONFactory factoryWithCampaignID:campaignID];
  });

  describe(@"campaignID", ^{
    it(@"is the campaignID passed to the factory method", ^{
      [[factory.campaignID should] equal:campaignID];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'campaign'", ^{
      [[[factory rootKey] should] equal:@"campaign"];
    });
  });
});

SPEC_END
