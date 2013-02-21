#import "LULocation.h"
#import "LULocationModelBuilder.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LULocationModelBuilder

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  if (attributes[@"location"]) {
    attributes = attributes[@"location"];
  }

  LULocation *location = [[LULocation alloc] init];
  location.extendedAddress = [attributes stringForKey:@"extended_address"];
  location.hours = [attributes stringForKey:@"hours"];
  location.lat = [attributes numberForKey:@"lat"];
  location.locality = [attributes stringForKey:@"locality"];
  location.locationID = [attributes numberForKey:@"id"];
  location.lng = [attributes numberForKey:@"lng"];
  location.name = [attributes stringForKey:@"name"];
  location.phone = [attributes stringForKey:@"phone"];
  location.postalCode = [attributes stringForKey:@"postal_code"];
  location.region = [attributes stringForKey:@"region"];
  location.streetAddress = [attributes stringForKey:@"street_address"];

  return location;
}

@end
