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

#import "LUUserAddressJSONFactory.h"

SPEC_BEGIN(LUUserAddressJSONFactorySpec)

describe(@"LUUserAddressJSONFactory", ^{
  __block LUUserAddressJSONFactory *factory;

  beforeEach(^{
    factory = [LUUserAddressJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUUserAddress", ^{
      NSDictionary *JSON = @{
        @"address_type" : @"home",
        @"extended_address" : @"Apt 1",
        @"id" : @1,
        @"locality" : @"Boston",
        @"postal_code" : @"02114",
        @"region" : @"MA",
        @"street_address" : @"123 Main St"
      };
      LUUserAddress *userAddress = [factory createFromAttributes:JSON];

      [[userAddress.addressID should] equal:@1];
      [[userAddress.addressType should] equal:@"home"];
      [[userAddress.extendedAddress should] equal:@"Apt 1"];
      [[userAddress.locality should] equal:@"Boston"];
      [[userAddress.postalCode should] equal:@"02114"];
      [[userAddress.region should] equal:@"MA"];
      [[userAddress.streetAddress should] equal:@"123 Main St"];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'user_address'", ^{
      [[[factory rootKey] should] equal:@"user_address"];
    });
  });
});

SPEC_END
