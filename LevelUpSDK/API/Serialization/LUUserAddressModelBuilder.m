#import "LUUserAddress.h"
#import "LUUserAddressModelBuilder.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUUserAddressModelBuilder

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  if (attributes[@"user_address"]) {
    attributes = attributes[@"user_address"];
  }

  LUUserAddress *userAddress = [[LUUserAddress alloc] init];
  userAddress.addressType = [attributes stringForKey:@"address_type"];
  userAddress.extendedAddress = [attributes stringForKey:@"extended_address"];
  userAddress.locality = [attributes stringForKey:@"locality"];
  userAddress.postalCode = [attributes stringForKey:@"postal_code"];
  userAddress.region = [attributes stringForKey:@"region"];
  userAddress.streetAddress = [attributes stringForKey:@"street_address"];
  userAddress.userAddressID = [attributes numberForKey:@"id"];

  return userAddress;
}

@end
