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

#import "LUAPIRequest.h"
#import "LURewardRequestFactory.h"

SPEC_BEGIN(LURewardRequestFactorySpec)

describe(@"LURewardRequestFactory", ^{
  // Public Methods

  __block LUAPIRequest *request;

  describe(@"requestForRewardSummaryAtLocationID:", ^{
    beforeEach(^{
      request = [LURewardRequestFactory requestForRewardSummaryAtLocationID:@1];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'locations/<id>/reward_summary'", ^{
      [[request.path should] equal:@"locations/1/reward_summary"];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    it(@"returns a request with no parameters", ^{
      [request.parameters shouldBeNil];
    });
  });

  describe(@"requestForRewardsAtLocationID:", ^{
    beforeEach(^{
      request = [LURewardRequestFactory requestForRewardsAtLocationID:@1];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'locations/<id>/rewards'", ^{
      [[request.path should] equal:@"locations/1/rewards"];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    it(@"returns a request with no parameters", ^{
      [request.parameters shouldBeNil];
    });
  });
});

SPEC_END
