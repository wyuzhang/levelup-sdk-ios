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
#import "LUUserAddressTypeTransformer.h"

@implementation LUUserAddress

+ (void)load {
  [NSValueTransformer setValueTransformer:[[LUUserAddressTypeTransformer alloc] init] forName:LUUserAddressTypeTransformerName];
}

#pragma mark - Creation

- (id)initWithAddressID:(NSNumber *)addressID addressType:(LUUserAddressType)addressType
        extendedAddress:(NSString *)extendedAddress latitude:(NSNumber *)latitude
               locality:(NSString *)locality longitude:(NSNumber *)longitude
             postalCode:(NSString *)postalCode region:(NSString *)region
          streetAddress:(NSString *)streetAddress {
  self = [super initWithExtendedAddress:extendedAddress latitude:latitude locality:locality longitude:longitude
                             postalCode:postalCode region:region streetAddress:streetAddress];
  if (!self) return nil;

  _addressID = addressID;
  _addressType = addressType;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:@"LUUserAddress [address=%p, addressID=%@, addressType=%@, %@]",
          self, self.addressID, [[self class] addressTypeStringForAddressType:self.addressType], [super debugDescription]];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUUserAddress [address=%p, addressID=%@, %@]",
          self, self.addressID, [super debugDescription]];
}

#pragma mark - Address Type transformations

+ (LUUserAddressType)addressTypeForString:(NSString *)addressTypeString {
  NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:LUUserAddressTypeTransformerName];
  return [[transformer reverseTransformedValue:addressTypeString] integerValue];
}

+ (NSString *)addressTypeStringForAddressType:(LUUserAddressType)addressType {
  NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:LUUserAddressTypeTransformerName];
  return [transformer transformedValue:@(addressType)];
}

@end
