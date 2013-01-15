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

@end
