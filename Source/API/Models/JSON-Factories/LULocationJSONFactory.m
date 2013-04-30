#import "LULocation.h"
#import "LULocationJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LULocationJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *extendedAddress = [attributes stringForKey:@"extended_address"];
  NSString *hours = [attributes stringForKey:@"hours"];
  NSNumber *lat = [attributes numberForKey:@"lat"];
  NSString *locality = [attributes stringForKey:@"locality"];
  NSNumber *locationID = [attributes numberForKey:@"id"];
  NSNumber *lng = [attributes numberForKey:@"lng"];
  NSString *name = [attributes stringForKey:@"name"];
  NSString *phone = [attributes stringForKey:@"phone"];
  NSString *postalCode = [attributes stringForKey:@"postal_code"];
  NSString *region = [attributes stringForKey:@"region"];
  NSString *streetAddress = [attributes stringForKey:@"street_address"];

  return [[LULocation alloc] initWithExtendedAddress:extendedAddress hours:hours lat:lat
                                            locality:locality locationID:locationID lng:lng
                                                name:name phone:phone postalCode:postalCode
                                              region:region streetAddress:streetAddress];
}

- (NSString *)rootKey {
  return @"location";
}

@end
