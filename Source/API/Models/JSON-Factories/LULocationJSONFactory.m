#import "LULocation.h"
#import "LULocationJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LULocationJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *extendedAddress = [attributes stringForKey:@"extended_address"];
  NSString *hours = [attributes stringForKey:@"hours"];
  NSNumber *latitude = [attributes numberForKey:@"lat"];
  NSString *locality = [attributes stringForKey:@"locality"];
  NSNumber *locationID = [attributes numberForKey:@"id"];
  NSNumber *longitude = [attributes numberForKey:@"lng"];
  NSString *name = [attributes stringForKey:@"name"];
  NSString *phone = [attributes stringForKey:@"phone"];
  NSString *postalCode = [attributes stringForKey:@"postal_code"];
  NSString *region = [attributes stringForKey:@"region"];
  NSString *streetAddress = [attributes stringForKey:@"street_address"];

  return [[LULocation alloc] initWithCategoryIDs:nil extendedAddress:extendedAddress hours:hours latitude:latitude
                                        locality:locality locationID:locationID longitude:longitude merchantID:nil
                                    merchantName:nil name:name phone:phone postalCode:postalCode region:region shown:YES
                                       streetAddress:streetAddress updatedAtDate:nil];
}

- (NSString *)rootKey {
  return @"location";
}

@end
