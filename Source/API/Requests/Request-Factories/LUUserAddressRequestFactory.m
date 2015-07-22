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
#import "LUUserAddress.h"
#import "LUUserAddressJSONFactory.h"
#import "LUUserAddressRequestFactory.h"

@implementation LUUserAddressRequestFactory

+ (LUAPIRequest *)requestForUserAddresses {
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:@"user_addresses"
                                 apiVersion:LUAPIVersion15
                                 parameters:nil
                               modelFactory:[LUUserAddressJSONFactory factory]];
}

+ (LUAPIRequest *)requestToCreateUserAddress:(LUUserAddress *)userAddress {
  NSDictionary *parameters = @{
    @"address_type" : userAddress.addressType,
    @"extended_address" : userAddress.extendedAddress,
    @"locality" : userAddress.locality,
    @"postal_code" : userAddress.postalCode,
    @"region" : userAddress.region,
    @"street_address" : userAddress.streetAddress
  };

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"user_addresses"
                                 apiVersion:LUAPIVersion15
                                 parameters:@{@"user_address" : parameters}
                               modelFactory:[LUUserAddressJSONFactory factory]];
}

@end
