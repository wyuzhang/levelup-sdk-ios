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

#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUClaimRequestFactory.h"

SPEC_BEGIN(LUClaimRequestFactorySpec)

describe(@"LUClaimRequestFactory", ^{
  // Public Methods

  __block LUAPIRequest *request;

  describe(@"requestToClaimCampaignWithCode:", ^{
    NSString *code = @"testcode";

    beforeEach(^{
      request = [LUClaimRequestFactory requestToClaimCampaignWithCode:code];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'codes/<code>/claims'", ^{
      NSString *expectedPath = [NSString stringWithFormat:@"codes/%@/claims", code];

      [[request.path should] equal:expectedPath];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });
  });

  describe(@"requestToClaimLegacyLoyaltyWithID:campaignID:", ^{
    NSString *legacyLoyaltyID = @"abc123";
    NSNumber *campaignID = @2;

    beforeEach(^{
      request = [LUClaimRequestFactory requestToClaimLegacyLoyaltyWithID:legacyLoyaltyID campaignID:campaignID];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'loyalties/legacy/<campaignid>/claims'", ^{
      NSString *expectedPath = [NSString stringWithFormat:@"loyalties/legacy/%@/claims", campaignID];

      [[request.path should] equal:expectedPath];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    it(@"returns a request with parameters including the legacy loyalty id", ^{
      NSDictionary *expectedParams = @{@"legacy_loyalty" : @{@"legacy_id" : legacyLoyaltyID}};

      [[request.parameters should] equal:expectedParams];
    });
  });
});

SPEC_END
