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

#import "LUAPIRequest.h"
#import "LUCampaignRequestFactory.h"

SPEC_BEGIN(LUCampaignRequestFactorySpec)

describe(@"LUCampaignRequestFactory", ^{
  // Public Methods

  describe(@"requestForMerchantsForCampaignWithID:", ^{
    __block LUAPIRequest *request;

    beforeEach(^{
      request = [LUCampaignRequestFactory requestForMerchantsForCampaignWithID:@1];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'campaigns/<id>/merchants'", ^{
      [[request.path should] equal:@"campaigns/1/merchants"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request with no parameters", ^{
      [request.parameters shouldBeNil];
    });
  });

  describe(@"requestForCampaignWithCode:", ^{
    __block LUAPIRequest *request;
    NSString *code = @"code";

    beforeEach(^{
      request = [LUCampaignRequestFactory requestForCampaignWithCode:code];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'codes/<code>/campaign'", ^{
      NSString *expectedPath = [NSString stringWithFormat:@"codes/%@/campaign", code];

      [[request.path should] equal:expectedPath];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request with no parameters", ^{
      [request.parameters shouldBeNil];
    });
  });

  describe(@"requestForCampaignWithID:", ^{
    __block LUAPIRequest *request;

    beforeEach(^{
      request = [LUCampaignRequestFactory requestForCampaignWithID:@1];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'campaigns/<id>'", ^{
      [[request.path should] equal:@"campaigns/1"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request with no parameters", ^{
      [request.parameters shouldBeNil];
    });
  });
});

SPEC_END
