#import "LUUserAddress.h"

@implementation LUUserAddress

#pragma mark - Creation

- (id)initWithAddressType:(NSString *)addressType extendedAddress:(NSString *)extendedAddress
                 locality:(NSString *)locality postalCode:(NSString *)postalCode region:(NSString *)region
            streetAddress:(NSString *)streetAddress userAddressID:(NSNumber *)userAddressID {
  self = [super init];
  if (!self) return nil;

  _addressType = addressType;
  _extendedAddress = extendedAddress;
  _locality = locality;
  _postalCode = postalCode;
  _region = region;
  _streetAddress = streetAddress;
  _userAddressID = userAddressID;

  return self;
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

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"LUUserAddress [addressType=%@, extendedAddress=%@, ID=%@, locality=%@, postalCode=%@, region=%@, streetAddress=%@]",
          self.addressType, self.extendedAddress, self.userAddressID, self.locality, self.postalCode, self.region,
          self.streetAddress];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUUserAddress [addressType=%@, ID=%@, streetAddress=%@]", self.addressType,
          self.userAddressID, self.streetAddress];
}

@end
