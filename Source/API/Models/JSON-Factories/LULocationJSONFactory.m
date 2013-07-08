#import "LULocation.h"
#import "LULocationJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LULocationJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *extendedAddress = [attributes lu_stringForKey:@"extended_address"];
  NSString *hours = [attributes lu_stringForKey:@"hours"];
  NSNumber *latitude = [attributes lu_numberForKey:@"lat"];
  NSString *locality = [attributes lu_stringForKey:@"locality"];
  NSNumber *locationID = [attributes lu_numberForKey:@"id"];
  NSNumber *longitude = [attributes lu_numberForKey:@"lng"];
  NSNumber *merchantID = [attributes lu_numberForKey:@"merchant_id"];
  NSString *name = [attributes lu_stringForKey:@"name"];
  NSString *phone = [attributes lu_stringForKey:@"phone"];
  NSString *postalCode = [attributes lu_stringForKey:@"postal_code"];
  NSString *region = [attributes lu_stringForKey:@"region"];
  NSString *streetAddress = [attributes lu_stringForKey:@"street_address"];

  return [[LULocation alloc] initWithCategoryIDs:nil descriptionHTML:nil extendedAddress:extendedAddress hours:hours
                                        latitude:latitude locality:locality locationID:locationID longitude:longitude
                                      merchantID:merchantID merchantName:nil name:name phone:phone postalCode:postalCode
                                          region:region shown:YES streetAddress:streetAddress updatedAtDate:nil
                                    webLocations:nil];
}

- (NSString *)rootKey {
  return @"location";
}

@end
