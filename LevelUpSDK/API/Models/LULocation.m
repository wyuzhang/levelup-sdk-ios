#import "LULocation.h"

@implementation LULocation

#pragma mark - Creation

- (id)initWithExtendedAddress:(NSString *)extendedAddress hours:(NSString *)hours
                          lat:(NSNumber *)lat locality:(NSString *)locality
                   locationID:(NSNumber *)locationID lng:(NSNumber *)lng name:(NSString *)name
                        phone:(NSString *)phone postalCode:(NSString *)postalCode
                       region:(NSString *)region streetAddress:(NSString *)streetAddress {
  self = [super init];
  if (!self) return nil;

  _extendedAddress = extendedAddress;
  _hours = hours;
  _lat = lat;
  _locality = locality;
  _locationID = locationID;
  _lng = lng;
  _name = name;
  _phone = phone;
  _postalCode = postalCode;
  _region = region;
  _streetAddress = streetAddress;

  return self;
}

#pragma mark - Public Methods

- (NSString *)fullStreetAddress {
  if (self.extendedAddress.length > 0) {
    return [NSString stringWithFormat:@"%@, %@", self.streetAddress, self.extendedAddress];
  }

  return self.streetAddress;
}

- (CLLocation *)location {
  if (self.lat && self.lng) {
    CLLocationCoordinate2D coord = self.coordinate;
    return [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
  } else {
    return nil;
  }
}

- (NSString *)singleLineAddress {
  return [NSString stringWithFormat:
          @"%@, %@, %@ %@",
          [self fullStreetAddress],
          self.locality,
          self.region,
          self.postalCode];
}

#pragma mark - MKAnnotation Methods

#if !defined(BOUNDED)
#define BOUNDED(A,B,C)  (MAX((B), MIN((C), A)))
#endif

- (CLLocationCoordinate2D)coordinate {
  if (self.lat && self.lng) {
    return CLLocationCoordinate2DMake(BOUNDED(self.lat.doubleValue, -90, 90), BOUNDED(self.lng.doubleValue, -180, 180));
  } else {
    return kCLLocationCoordinate2DInvalid;
  }
}

- (NSString *)title {
  return [self fullStreetAddress];
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"LULocation [extendedAddress=%@, hours=%@, ID=%@, lat=%@, locality=%@, lng=%@, name=%@, phone=%@, postalCode=%@, region=%@, streetAddress=%@]",
          self.extendedAddress, self.hours, self.locationID, self.lat, self.locality, self.lng,
          self.name, self.phone, self.postalCode, self.region, self.streetAddress];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LULocation [ID=%@, streetAddress=%@]", self.locationID,
          self.streetAddress];
}

@end
