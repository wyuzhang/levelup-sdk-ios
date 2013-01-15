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

#pragma mark - MKAnnotation Methods

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
