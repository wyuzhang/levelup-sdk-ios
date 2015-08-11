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

#import "LUBaseLocation.h"

/** A user address's type. */
typedef NS_ENUM(NSInteger, LUUserAddressType) {
  LUUserAddressTypeBilling,
  LUUserAddressTypeDelivery,
  LUUserAddressTypeHome,
  LUUserAddressTypeOther,
  LUUserAddressTypePayment,
  LUUserAddressTypeShipping,
  LUUserAddressTypeWork
};

/**
 `LUUserAddress` is a representation of a user's address in the LevelUp system.
 */
@interface LUUserAddress : LUBaseLocation

/**
 The unique identifier for the address.
 */
@property (nonatomic, copy, readonly) NSNumber *addressID;

/**
 The address's type. Valid values are `billing`, `delivery`, `home`, `other`, `payment`, `shipping`, and `work`.
 */
@property (nonatomic, assign) LUUserAddressType addressType;

/**
 Returns an enumerated value representing a user address's type.
 @param addressTypeString The string representation of the type. This string is case insensitive.
 */
+ (LUUserAddressType)addressTypeForString:(NSString *)addressTypeString;

/**
 Returns a string representation of the user address's type for display.
 The returned string will be downcased.
 @param addressType The enumerated value for the address's type.
 */
+ (NSString *)addressTypeStringForAddressType:(LUUserAddressType)addressType;

- (id)initWithAddressID:(NSNumber *)addressID addressType:(LUUserAddressType)addressType
        extendedAddress:(NSString *)extendedAddress latitude:(NSNumber *)latitude
               locality:(NSString *)locality longitude:(NSNumber *)longitude
             postalCode:(NSString *)postalCode region:(NSString *)region
          streetAddress:(NSString *)streetAddress;

@end
