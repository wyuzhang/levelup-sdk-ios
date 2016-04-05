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

@implementation LUBaseLocation

#pragma mark - Creation

- (id)initWithExtendedAddress:(NSString *)extendedAddress latitude:(NSNumber *)latitude
                     locality:(NSString *)locality longitude:(NSNumber *)longitude
                   postalCode:(NSString *)postalCode region:(NSString *)region
                streetAddress:(NSString *)streetAddress {
  self = [super init];
  if (!self) return nil;

  _extendedAddress = extendedAddress;
  _latitude = latitude;
  _locality = locality;
  _longitude = longitude;
  _postalCode = postalCode;
  _region = region;
  _streetAddress = streetAddress;

  return self;
}

#pragma mark - Public Methods

+ (NSArray *)baseLocations:(NSArray *)baseLocations sortedByDistanceFromLocation:(CLLocation *)startLocation {
  return [baseLocations sortedArrayUsingComparator:^(LUBaseLocation *location1, LUBaseLocation *location2) {
    if (startLocation) {
      CLLocationDistance distance1 = [startLocation distanceFromLocation:location1.location];
      CLLocationDistance distance2 = [startLocation distanceFromLocation:location2.location];

      if (distance1 > distance2) {
        return NSOrderedDescending;
      } else if (distance1 < distance2) {
        return NSOrderedAscending;
      } else {
        return NSOrderedSame;
      }
    } else {
      return [location1.streetAddress compare:location2.streetAddress];
    }
  }];
}

- (NSString *)fullStreetAddress {
  if (self.extendedAddress.length > 0) {
    return [NSString stringWithFormat:@"%@, %@", self.streetAddress, self.extendedAddress];
  }

  return self.streetAddress;
}

- (CLLocation *)location {
  if (self.latitude && self.longitude) {
    CLLocationCoordinate2D coord = self.coordinate;
    return [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
  } else {
    return nil;
  }
}

- (NSString *)singleLineAddress {
  return [NSString stringWithFormat:@"%@, %@, %@ %@", [self fullStreetAddress], self.locality,
          self.region, self.postalCode];
}

- (CLLocationCoordinate2D)coordinate {
  if (self.latitude && self.longitude) {
    return CLLocationCoordinate2DMake(self.latitude.doubleValue, self.longitude.doubleValue);
  } else {
    return kCLLocationCoordinate2DInvalid;
  }
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:@"extendedAddress=%@, latitude=%@ locality=%@, longitude=%@, postalCode=%@, region=%@, streetAddress=%@",
          self.extendedAddress, self.latitude, self.locality, self.longitude, self.postalCode, self.region, self.streetAddress];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"streetAddress=%@, extendedAddress=%@, locality=%@, region=%@",
          self.streetAddress, self.extendedAddress, self.locality, self.region];
}

@end
