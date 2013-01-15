#import "LUMerchandiseOrder.h"
#import "LUUserAddress.h"

@implementation LUMerchandiseOrder

#pragma mark - Public Methods

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

@end
