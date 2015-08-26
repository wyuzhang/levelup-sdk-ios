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
#import "LULocation.h"
#import "NSURL+LUAdditions.h"

@implementation LULocation

#pragma mark - Creation

- (id)initWithCategoryIDs:(NSArray *)categoryIDs categoryNames:(NSArray *)categoryNames
          deliveryMenuURL:(NSURL *)deliveryMenuURL descriptionHTML:(NSString *)descriptionHTML
          extendedAddress:(NSString *)extendedAddress hours:(NSString *)hours
                 latitude:(NSNumber *)latitude locality:(NSString *)locality
               locationID:(NSNumber *)locationID longitude:(NSNumber *)longitude
               merchantID:(NSNumber *)merchantID merchantName:(NSString *)merchantName
                     name:(NSString *)name phone:(NSString *)phone
            pickupMenuURL:(NSURL *)pickupMenuURL postalCode:(NSString *)postalCode
                   region:(NSString *)region shown:(BOOL)shown
            streetAddress:(NSString *)streetAddress updatedAtDate:(NSDate *)updatedAtDate
             webLocations:(LUWebLocations *)webLocations {
  self = [super initWithExtendedAddress:extendedAddress latitude:latitude locality:locality longitude:longitude
                             postalCode:postalCode region:region streetAddress:streetAddress];
  if (!self) return nil;

  _categoryIDs = categoryIDs;
  _categoryNames = categoryNames;
  _deliveryMenuURL = deliveryMenuURL;
  _descriptionHTML = descriptionHTML;
  _hours = hours;
  _locationID = locationID;
  _merchantID = merchantID;
  _merchantName = merchantName;
  _name = name;
  _phone = phone;
  _pickupMenuURL = pickupMenuURL;
  _shown = shown;
  _summary = NO;
  _updatedAtDate = updatedAtDate;
  _webLocations = webLocations;

  return self;
}

- (id)initWithCategoryIDs:(NSArray *)categoryIDs latitude:(NSNumber *)latitude
               locationID:(NSNumber *)locationID longitude:(NSNumber *)longitude
               merchantID:(NSNumber *)merchantID merchantName:(NSString *)merchantName
                     name:(NSString *)name shown:(BOOL)shown updatedAtDate:(NSDate *)updatedAtDate {
  self = [super initWithExtendedAddress:nil latitude:latitude locality:nil longitude:longitude postalCode:nil region:nil streetAddress:nil];
  if (!self) return nil;

  _categoryIDs = categoryIDs;
  _locationID = locationID;
  _merchantID = merchantID;
  _merchantName = merchantName;
  _name = name;
  _shown = shown;
  _summary = YES;
  _updatedAtDate = updatedAtDate;

  return self;
}

#pragma mark - Public Methods

- (NSString *)fullStreetAddress {
  if (self.extendedAddress.length > 0) {
    return [NSString stringWithFormat:@"%@, %@", self.streetAddress, self.extendedAddress];
  }

  return self.streetAddress;
}

- (NSURL *)imageURL {
  return [NSURL lu_imageURLForLocationWithID:self.locationID];
}

- (NSString *)singleLineAddress {
  return [NSString stringWithFormat:@"%@, %@, %@ %@", [self fullStreetAddress], self.locality,
          self.region, self.postalCode];
}

#pragma mark - MKAnnotation Methods

- (NSString *)subtitle {
  return self.name;
}

- (NSString *)title {
  return self.merchantName;
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:@"LULocation [address=%p, categoryIDs=%@, categoryNames=%@, deliveryMenuURL=%@, descriptionHTML=%@, hours=%@, locationID=%@, merchantID=%@, merchantName=%@, name=%@, phone=%@, pickupMenuURL=%@, shown=%@, summary=%@, updatedAtDate=%@, %@]",
          self, self.categoryIDs, self.categoryNames, self.deliveryMenuURL, self.descriptionHTML, self.hours,
          self.locationID, self.merchantID, self.merchantName, self.name, self.phone, self.pickupMenuURL, @(self.shown),
          @(self.summary), self.updatedAtDate, [super debugDescription]];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LULocation [address=%p, locationID=%@, merchantName=%@, name=%@, %@]",
          self, self.locationID, self.merchantName, self.name, [super debugDescription]];
}

@end
