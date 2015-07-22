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

@implementation LUUserAddress

- (id)initWithAddressID:(NSNumber *)addressID addressType:(NSString *)addressType
        extendedAddress:(NSString *)extendedAddress locality:(NSString *)locality
             postalCode:(NSString *)postalCode region:(NSString *)region
          streetAddress:(NSString *)streetAddress {
  self = [super init];
  if (!self) return nil;

  _addressID = addressID;
  _addressType = addressType;
  _extendedAddress = extendedAddress;
  _locality = locality;
  _postalCode = postalCode;
  _region = region;
  _streetAddress = streetAddress;

  return self;
}

- (NSString *)debugDescription {
  return [NSString stringWithFormat:@"LUUserAddress [address=%p, addressID=%@, addressType=%@, extendedAddress=%@, locality=%@, postalCode=%@, region=%@, streetAddress=%@]",
          self, self.addressID, self.addressType, self.extendedAddress, self.locality, self.postalCode, self.region, self.streetAddress];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUUserAddress [address=%p, streetAddress=%@, extendedAddress=%@, locality=%@, region=%@]",
          self, self.streetAddress, self.extendedAddress, self.locality, self.region];
}

@end
