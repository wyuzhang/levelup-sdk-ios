#import "LUJSONDeserializer.h"
#import "LUUserAddress.h"

@implementation LUUserAddress

#pragma mark -
#pragma mark Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"user_address"];
  }
}

#pragma mark -
#pragma mark Public Methods

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
