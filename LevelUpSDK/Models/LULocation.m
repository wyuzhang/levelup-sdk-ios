#import "LUJSONDeserializer.h"
#import "LULocation.h"

@implementation LULocation

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"location"];
  }
}

#pragma mark - Properties

- (CLLocation *)location {
  CLLocationCoordinate2D coord = self.coordinate;
  return [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
}

- (NSString *)singleLineAddress {
  return [NSString stringWithFormat:
          @"%@, %@, %@ %@",
          [self fullStreetAddress],
          self.locality,
          self.region,
          self.postalCode];
}

- (NSString *)fullStreetAddress {
  if (self.extendedAddress.length > 0) {
    return [NSString stringWithFormat:@"%@, %@", self.streetAddress, self.extendedAddress];
  }

  return self.streetAddress;
}

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.extendedAddress) {
    total += [self.extendedAddress hash] * 11;
  }
  if (self.hours) {
    total += [self.hours intValue] * 13;
  }
  if (self.lat) {
    total += [self.lat intValue] * 17;
  }
  if (self.locality) {
    total += [self.locality hash] * 23;
  }
  if (self.lng) {
    total += [self.lng intValue] * 29;
  }
  if (self.modelId) {
    total += [self.modelId intValue] * 31;
  }
  if (self.phone) {
    total += [self.phone hash] * 37;
  }
  if (self.postalCode) {
    total += [self.postalCode hash] * 41;
  }
  if (self.region) {
    total += [self.region hash] * 47;
  }
  if (self.streetAddress) {
    total += [self.streetAddress hash] * 53;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LULocation class]]) {
    LULocation *otherLocation = (LULocation *)otherObject;

    BOOL extendedAddressEqual = ((!otherLocation.extendedAddress && !self.extendedAddress) ||
        (otherLocation.extendedAddress && self.extendedAddress &&
        [otherLocation.extendedAddress isEqualToString:self.extendedAddress]));

    BOOL hoursEqual = ((!otherLocation.hours && !self.hours) ||
        (otherLocation.hours && self.hours &&
        [otherLocation.hours isEqualToString:self.hours]));

    BOOL latEqual = ((!otherLocation.lat && !self.lat) ||
        (otherLocation.lat && self.lat &&
        [otherLocation.lat intValue] == [self.lat intValue]));

    BOOL localityEqual = ((!otherLocation.locality && !self.locality) ||
        (otherLocation.locality && self.locality &&
        [otherLocation.locality isEqualToString:self.locality]));

    BOOL lngEqual = ((!otherLocation.lng && !self.lng) ||
        (otherLocation.lng && self.lng &&
        [otherLocation.lng intValue] == [self.lng intValue]));

    BOOL modelIdEqual = ((!otherLocation.modelId && !self.modelId) ||
        (otherLocation.modelId && self.modelId &&
        [otherLocation.modelId intValue] == [self.modelId intValue]));

    BOOL phoneEqual = ((!otherLocation.phone && !self.phone) ||
        (otherLocation.phone && self.phone &&
        [otherLocation.phone isEqualToString:self.phone]));

    BOOL postalCodeEqual = ((!otherLocation.postalCode && !self.postalCode) ||
        (otherLocation.postalCode && self.postalCode &&
        [otherLocation.postalCode isEqualToString:self.postalCode]));

    BOOL regionEqual = ((!otherLocation.region && !self.region) ||
        (otherLocation.region && self.region &&
        [otherLocation.region isEqualToString:self.region]));

    BOOL streetAddressEqual = ((!otherLocation.streetAddress && !self.streetAddress) ||
        (otherLocation.streetAddress && self.streetAddress &&
        [otherLocation.streetAddress isEqualToString:self.streetAddress]));

    return extendedAddressEqual && hoursEqual && latEqual && localityEqual && lngEqual &&
        modelIdEqual && phoneEqual && postalCodeEqual && regionEqual &&
        streetAddressEqual;
  }

  return NO;
}

#pragma mark - NSObject (MKAnnotation) Methods

#if !defined(BOUNDED)
#define BOUNDED(A,B,C)  (MAX((B), MIN((C), A)))
#endif

- (CLLocationCoordinate2D)coordinate {
  return CLLocationCoordinate2DMake(BOUNDED([self.lat doubleValue], -90, 90), BOUNDED([self.lng doubleValue], -180, 180));
}

- (NSString *)title {
  return [self fullStreetAddress];
}

@end
