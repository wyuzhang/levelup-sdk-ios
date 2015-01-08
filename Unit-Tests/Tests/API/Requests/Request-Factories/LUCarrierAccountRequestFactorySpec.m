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

#import "LUCarrierAccountRequestFactory.h"

SPEC_BEGIN(LUCarrierAccountRequestFactorySpec)

describe(@"LUCarrierAccountRequestFactory", ^{
  __block LUAPIRequest *request;

  // Public Methods

  describe(@"requestForCarrierAccountIdentification", ^{
    beforeEach(^{
      request = [LUCarrierAccountRequestFactory requestForCarrierAccountIdentification];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'carrier_accounts'", ^{
      [[request.path should] equal:@"carrier_accounts"];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });
  });

  describe(@"requestForUpdatedCarrierAccountWithID:", ^{
    beforeEach(^{
      request = [LUCarrierAccountRequestFactory requestForUpdatedCarrierAccountWithID:@123];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'carrier_accounts/id'", ^{
      [[request.path should] equal:[NSString stringWithFormat:@"carrier_accounts/%@", @123]];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });
  });

  describe(@"requestToUpdateCarrierAccountWithID:mobileDeviceNumber:carrierName:", ^{
    NSString *apiKey = @"api-key";

    beforeEach(^{
      [LUAPIClient setupWithAppID:@"1" APIKey:apiKey];

      request = [LUCarrierAccountRequestFactory requestToUpdateCarrierAccountWithID:@123
                                                                 mobileDeviceNumber:@"1111111111"
                                                                        carrierName:@"SPR"];
    });

    it(@"returns a PUT request", ^{
      [[request.method should] equal:@"PUT"];
    });

    it(@"returns a request to the path 'carrier_accounts/id'", ^{
      [[request.path should] equal:[NSString stringWithFormat:@"carrier_accounts/%@", @123]];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    it(@"returns a request with parameters including the carrier name and mobile device number", ^{
      NSDictionary *updatedCarrierParams = @{
        @"carrier_account" : @{
        @"carrier" : @"SPR",
        @"mobile_device_number" : @"1111111111"
        }
      };

      [[request.parameters should] equal:updatedCarrierParams];
    });
  });
});

SPEC_END
