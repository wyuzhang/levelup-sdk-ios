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
#import "LUUserAddress+Fixtures.h"
#import "LUUserAddressRequestFactory.h"

SPEC_BEGIN(LUUserAddressRequestFactorySpec)

describe(@"LUUserAddressRequestFactory", ^{
  // Public Methods

  __block LUAPIRequest *request;

  describe(@"requestForUserAddresses", ^{
    beforeEach(^{
      request = [LUUserAddressRequestFactory requestForUserAddresses];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'user_addresses'", ^{
      [[request.path should] equal:@"user_addresses"];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });
  });

  describe(@"requestToCreateUserAddress:", ^{
    __block LUUserAddress *userAddress;

    beforeEach(^{
      userAddress = [LUUserAddress fixture];

      request = [LUUserAddressRequestFactory requestToCreateUserAddress:userAddress];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'user_addresses'", ^{
      [[request.path should] equal:@"user_addresses"];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    it(@"returns a request with parameters for the user address", ^{
      NSDictionary *expectedParams = @{
        @"user_address" : @{
          @"address_type" : userAddress.addressType,
          @"extended_address" : userAddress.extendedAddress,
          @"locality" : userAddress.locality,
          @"postal_code" : userAddress.postalCode,
          @"region" : userAddress.region,
          @"street_address" : userAddress.streetAddress
        }
      };

      [[request.parameters should] equal:expectedParams];
    });
  });
});

SPEC_END
