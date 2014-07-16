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
#import "LULocationCreditRequestFactory.h"

SPEC_BEGIN(LULocationCreditRequestFactorySpec)

describe(@"LULocationCreditRequestFactory", ^{
  // Public Methods

  __block LUAPIRequest *request;

  describe(@"requestForCreditAtLocationID:", ^{
    beforeEach(^{
      [LUAPIClient setupWithAppID:@"1" APIKey:@"api-key"];
      request = [LULocationCreditRequestFactory requestForCreditAtLocationID:@1];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'locations/:id/credit'", ^{
      [[request.path should] equal:@"locations/1/credit"];
    });

    context(@"when there is an access token", ^{
      beforeEach(^{
        [LUAPIClient sharedClient].accessToken = @"access-token";
        request = [LULocationCreditRequestFactory requestForCreditAtLocationID:@1];
      });

      it(@"returns a request to version 15 of the API", ^{
        [[request.apiVersion should] equal:LUAPIVersion15];
      });
    });

    context(@"when there is no access token", ^{
      beforeEach(^{
        [LUAPIClient sharedClient].accessToken = nil;
        request = [LULocationCreditRequestFactory requestForCreditAtLocationID:@1];
      });

      it(@"returns a request to version 14 of the API", ^{
        [[request.apiVersion should] equal:LUAPIVersion14];
      });
    });
  });
});

SPEC_END
