#import "LUDictionarySerializer.h"
#import "LUJSONDeserializer.h"
#import "LUMerchandiseOrder.h"
#import "LUUserAddress.h"

@implementation LUMerchandiseOrder

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"merchandise_order"];
  }
}

#pragma mark - Public Methods

- (NSDictionary *)parameters {
  return [LUDictionarySerializer parametersForModel:self withNonBlankAttributesNamed:@[@"address", @"firstName", @"lastName", @"locality", @"region", @"unit", @"zip"]];
}

#pragma mark - Properties

- (NSString *)address {
  return self.shippingAddress.streetAddress;
}

- (NSString *)locality {
  return self.shippingAddress.locality;
}

- (NSString *)region {
  return self.shippingAddress.region;
}

- (void)setAddress:(NSString *)address {
  self.shippingAddress.streetAddress = address;
}

- (void)setLocality:(NSString *)locality {
  self.shippingAddress.locality = locality;
}

- (void)setRegion:(NSString *)region {
  self.shippingAddress.region = region;
}

- (void)setUnit:(NSString *)unit {
  self.shippingAddress.extendedAddress = unit;
}

- (void)setZip:(NSString *)zip {
  self.shippingAddress.postalCode = zip;
}

- (LUUserAddress *)shippingAddress {
  if (!_shippingAddress) {
    _shippingAddress = [[LUUserAddress alloc] init];
  }

  return _shippingAddress;
}

- (NSString *)unit {
  return self.shippingAddress.extendedAddress;
}

- (NSString *)zip {
  return self.shippingAddress.postalCode;
}

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.address) {
    total += [self.address hash] * 11;
  }
  if (self.firstName) {
    total += [self.firstName hash] * 13;
  }
  if (self.lastName) {
    total += [self.lastName hash] * 17;
  }
  if (self.locality) {
    total += [self.locality hash] * 19;
  }
  if (self.modelId) {
    total += [self.modelId intValue] * 23;
  }
  if (self.region) {
    total += [self.region hash] * 29;
  }
  if (self.shippingAddress) {
    total += [self.shippingAddress hash] * 31;
  }
  if (self.unit) {
    total += [self.unit hash] * 37;
  }
  if (self.zip) {
    total += [self.zip hash] * 41;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUMerchandiseOrder class]]) {
    LUMerchandiseOrder *otherMerchandiseOrder = (LUMerchandiseOrder *)otherObject;

    BOOL addressEqual = ((!otherMerchandiseOrder.address && !self.address) ||
        (otherMerchandiseOrder.address && self.address &&
        [otherMerchandiseOrder.address isEqualToString:self.address]));

    BOOL firstNameEqual = ((!otherMerchandiseOrder.firstName && !self.firstName) ||
        (otherMerchandiseOrder.firstName && self.firstName &&
        [otherMerchandiseOrder.firstName isEqualToString:self.firstName]));

    BOOL lastNameEqual = ((!otherMerchandiseOrder.lastName && !self.lastName) ||
        (otherMerchandiseOrder.lastName && self.lastName &&
        [otherMerchandiseOrder.lastName isEqualToString:self.lastName]));

    BOOL localityEqual = ((!otherMerchandiseOrder.locality && !self.locality) ||
        (otherMerchandiseOrder.locality && self.locality &&
        [otherMerchandiseOrder.locality isEqualToString:self.locality]));

    BOOL modelIdEqual = ((!otherMerchandiseOrder.modelId && !self.modelId) ||
        (otherMerchandiseOrder.modelId && self.modelId &&
        [otherMerchandiseOrder.modelId intValue] == [self.modelId intValue]));

    BOOL regionEqual = ((!otherMerchandiseOrder.region && !self.region) ||
        (otherMerchandiseOrder.region && self.region &&
        [otherMerchandiseOrder.region isEqualToString:self.region]));

    BOOL shippingAddressEqual = ((!otherMerchandiseOrder.shippingAddress && !self.shippingAddress) ||
        (otherMerchandiseOrder.shippingAddress && self.shippingAddress &&
        [otherMerchandiseOrder.shippingAddress isEqual:self.shippingAddress]));

    BOOL unitEqual = ((!otherMerchandiseOrder.unit && !self.unit) ||
        (otherMerchandiseOrder.unit && self.unit &&
        [otherMerchandiseOrder.unit isEqualToString:self.unit]));

    BOOL zipEqual = ((!otherMerchandiseOrder.zip && !self.zip) ||
        (otherMerchandiseOrder.zip && self.zip &&
        [otherMerchandiseOrder.zip isEqualToString:self.zip]));

    return addressEqual && firstNameEqual && lastNameEqual && localityEqual &&
        modelIdEqual && regionEqual && shippingAddressEqual && unitEqual &&
        zipEqual;
  }

  return NO;
}

@end
