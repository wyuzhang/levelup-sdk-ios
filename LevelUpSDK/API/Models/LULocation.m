#import "LULocation.h"

@implementation LULocation

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

@end
