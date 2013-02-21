#import "LUUserAddress.h"

@implementation LUUserAddress

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

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"UserAddress [addressType=%@, extendedAddress=%@, ID=%@, locality=%@, postalCode=%@, region=%@, streetAddress=%@]",
          self.addressType, self.extendedAddress, self.userAddressID, self.locality, self.postalCode, self.region,
          self.streetAddress];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"UserAddress [addressType=%@, ID=%@, streetAddress=%@]", self.addressType,
          self.userAddressID, self.streetAddress];
}

@end
