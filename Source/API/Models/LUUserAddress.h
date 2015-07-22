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

#import "LUAPIModel.h"

/**
 `LUUserAddress` is a representation of a user's address in the LevelUp system.
 */
@interface LUUserAddress : LUAPIModel

/**
 The unique identifier for this address.
 */
@property (nonatomic, copy, readonly) NSNumber *addressID;

/**
 The address's type. Valid values are `billing`, `delivery`, `home`, `other`, `payment`, `shipping`, and `work`.
 */
@property (nonatomic, copy) NSString *addressType;

/**
 An optional "extended" address. An example would be an apartment number.
 */
@property (nonatomic, copy) NSString *extendedAddress;

/**
 The address's town or city.
 */
@property (nonatomic, copy) NSString *locality;

/**
 The address's postal code.
 */
@property (nonatomic, copy) NSString *postalCode;

/**
 The address's region, such as a state or province.
 */
@property (nonatomic, copy) NSString *region;

/**
 The street address. If the address has a second line (such as an apartment number),
 this will be stored separately in the `extendedAddress` field.
 */
@property (nonatomic, copy) NSString *streetAddress;

- (id)initWithAddressID:(NSNumber *)addressID addressType:(NSString *)addressType
        extendedAddress:(NSString *)extendedAddress locality:(NSString *)locality
             postalCode:(NSString *)postalCode region:(NSString *)region
          streetAddress:(NSString *)streetAddress;

@end
