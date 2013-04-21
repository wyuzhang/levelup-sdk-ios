#import "LUUserAddress.h"
#import "LUUserAddressJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUUserAddressJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *addressType = [attributes stringForKey:@"address_type"];
  NSString *extendedAddress = [attributes stringForKey:@"extended_address"];
  NSString *locality = [attributes stringForKey:@"locality"];
  NSString *postalCode = [attributes stringForKey:@"postal_code"];
  NSString *region = [attributes stringForKey:@"region"];
  NSString *streetAddress = [attributes stringForKey:@"street_address"];
  NSNumber *userAddressID = [attributes numberForKey:@"id"];

  return [[LUUserAddress alloc] initWithAddressType:addressType extendedAddress:extendedAddress locality:locality
                                         postalCode:postalCode region:region streetAddress:streetAddress
                                      userAddressID:userAddressID];
}

- (NSString *)rootKey {
  return @"user_address";
}

@end
