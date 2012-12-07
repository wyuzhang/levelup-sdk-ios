#import "LUJSONDeserializer.h"
#import "LUUserAddress.h"

@implementation LUUserAddress

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"user_address"];
  }
}

#pragma mark - Public Methods

- (BOOL)isHomeAddress {
  return [self.addressType isEqualToString:@"home"];
}

- (BOOL)isOtherAddress {
  return [self.addressType isEqualToString:@"other"];
}

- (BOOL)isWorkAddress {
  return [self.addressType isEqualToString:@"work"];
}

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.addressType) {
    total += [self.addressType hash] * 11;
  }
  if (self.extendedAddress) {
    total += [self.extendedAddress hash] * 13;
  }
  if (self.locality) {
    total += [self.locality hash] * 17;
  }
  if (self.modelId) {
    total += [self.modelId intValue] * 19;
  }
  if (self.postalCode) {
    total += [self.postalCode hash] * 23;
  }
  if (self.region) {
    total += [self.region hash] * 29;
  }
  if (self.streetAddress) {
    total += [self.streetAddress hash] * 31;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUUserAddress class]]) {
    LUUserAddress *otherUserAddress = (LUUserAddress *)otherObject;

    BOOL addressTypeEqual = ((!otherUserAddress.addressType && !self.addressType) ||
        (otherUserAddress.addressType && self.addressType &&
        [otherUserAddress.addressType isEqualToString:self.addressType]));

    BOOL extendedAddressEqual = ((!otherUserAddress.extendedAddress && !self.extendedAddress) ||
        (otherUserAddress.extendedAddress && self.extendedAddress &&
        [otherUserAddress.extendedAddress isEqualToString:self.extendedAddress]));

    BOOL localityEqual = ((!otherUserAddress.locality && !self.locality) ||
        (otherUserAddress.locality && self.locality &&
        [otherUserAddress.locality isEqualToString:self.locality]));

    BOOL modelIdEqual = ((!otherUserAddress.modelId && !self.modelId) ||
        (otherUserAddress.modelId && self.modelId &&
        [otherUserAddress.modelId intValue] == [self.modelId intValue]));

    BOOL postalCodeEqual = ((!otherUserAddress.postalCode && !self.postalCode) ||
        (otherUserAddress.postalCode && self.postalCode &&
        [otherUserAddress.postalCode isEqualToString:self.postalCode]));

    BOOL regionEqual = ((!otherUserAddress.region && !self.region) ||
        (otherUserAddress.region && self.region &&
        [otherUserAddress.region isEqualToString:self.region]));

    BOOL streetAddressEqual = ((!otherUserAddress.streetAddress && !self.streetAddress) ||
        (otherUserAddress.streetAddress && self.streetAddress &&
        [otherUserAddress.streetAddress isEqualToString:self.streetAddress]));

    return addressTypeEqual && extendedAddressEqual && localityEqual && modelIdEqual &&
        postalCodeEqual && regionEqual && streetAddressEqual;
  }

  return NO;
}

@end
