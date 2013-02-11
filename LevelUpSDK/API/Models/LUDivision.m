#import "LUDivision.h"

@implementation LUDivision

#pragma mark - Public Methods

- (CLLocation *)location {
  if (self.lat && self.lng) {
    return [[CLLocation alloc] initWithLatitude:self.lat.doubleValue longitude:self.lng.doubleValue];
  } else {
    return nil;
  }
}

@end
