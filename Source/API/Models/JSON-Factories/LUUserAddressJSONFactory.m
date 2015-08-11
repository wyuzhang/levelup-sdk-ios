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

#import "LUUserAddress.h"
#import "LUUserAddressJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUUserAddressJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSNumber *addressID = [attributes lu_numberForKey:@"id"];
  LUUserAddressType addressType = [LUUserAddress addressTypeForString:[attributes lu_stringForKey:@"address_type"]];
  NSString *extendedAddress = [attributes lu_stringForKey:@"extended_address"];
  NSNumber *latitude = [attributes lu_numberForKey:@"latitude"];
  NSString *locality = [attributes lu_stringForKey:@"locality"];
  NSNumber *longitude = [attributes lu_numberForKey:@"longitude"];
  NSString *postalCode = [attributes lu_stringForKey:@"postal_code"];
  NSString *region = [attributes lu_stringForKey:@"region"];
  NSString *streetAddress = [attributes lu_stringForKey:@"street_address"];

  return [[LUUserAddress alloc] initWithAddressID:addressID addressType:addressType extendedAddress:extendedAddress
                                         latitude:latitude locality:locality longitude:longitude
                                       postalCode:postalCode region:region streetAddress:streetAddress];
}

- (NSString *)rootKey {
  return @"user_address";
}

@end
