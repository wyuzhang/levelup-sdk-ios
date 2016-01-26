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

#import <CoreLocation/CoreLocation.h>
#import "LUAPIModel.h"

/**
 `LUBaseLocation` is a representation of an address in the LevelUp system.
 */
@interface LUBaseLocation : LUAPIModel

/**
 An optional "extended" address for the location. An example would be an apartment number.
 */
@property (nonatomic, copy) NSString *extendedAddress;

/**
 The latitude of the location.
 */
@property (nonatomic, copy, readonly) NSNumber *latitude;

/**
 The location's town or city.
 */
@property (nonatomic, copy) NSString *locality;

/**
 The longitude of the location.
 */
@property (nonatomic, copy, readonly) NSNumber *longitude;

/**
 The location's postal code.
 */
@property (nonatomic, copy) NSString *postalCode;

/**
 The location's region, such as a state or province.
 */
@property (nonatomic, copy) NSString *region;

/**
 The location's street address. If the address has a second line (such as an apartment number),
 this will be stored separately in the `extendedAddress` field.
 */
@property (nonatomic, copy) NSString *streetAddress;

/**
 Sorts an `NSArray` of `LUBaseLocation`s in ascending order of distance from a given `CLLocation`.
 If no input `CLLocation` is given, this will sort the `LUBaseLocation`s alphabetically based on their street addresses.

 @param baseLocations The `NSArray` of `LUBaseLocation`s to be sorted.
 @param startLocation The `CLLocation` for which distance from will be measured.

 @return The sorted `NSArray` of `LUBaseLocation`s.
 */
+ (NSArray *)baseLocations:(NSArray *)baseLocations sortedByDistanceFromLocation:(CLLocation *)startLocation;

/**
 A `CLLocationCoordinate2D` instance generated from this location's latitude and longitude.
 */
- (CLLocationCoordinate2D)coordinate;

/**
 If the location has both a `streetAddress` and an `extendedAddress`, this will return both values
 joined by a comma. For example, "123 Main Street, Apt 2A". When an `extendedAddress` is not present,
 only the `streetAddress` will be returned.
 */
- (NSString *)fullStreetAddress;

/**
 A `CLLocation` instance generated from this location's latitude and longitude.
 */
- (CLLocation *)location;

/**
 A helper method which returns all the address fields in one line. The format is
 "<full street address>, <locality>, <region> <postal code>". For example: "123 Main Street, Apt 2A,
 Boston, MA 01234".
 */
- (NSString *)singleLineAddress;

- (id)initWithExtendedAddress:(NSString *)extendedAddress latitude:(NSNumber *)latitude
                     locality:(NSString *)locality longitude:(NSNumber *)longitude
                   postalCode:(NSString *)postalCode region:(NSString *)region
                streetAddress:(NSString *)streetAddress;

@end
