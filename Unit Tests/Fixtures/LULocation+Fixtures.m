#import "LULocation+Fixtures.h"
#import "LULocationJSONFactory.h"

@implementation LULocation (Fixtures)

+ (NSDictionary *)fullJSONObject {
  return @{
    @"extended_address" : @"Apt E",
    @"hours" : @"M-F 9am-5pm",
    @"id" : @1,
    @"lat" : @70,
    @"locality" : @"Boston",
    @"lng" : @-45,
    @"name" : @"Test Location",
    @"phone" : @"617-123-1234",
    @"postal_code" : @"01234",
    @"region" : @"MA",
    @"street_address" : @"1 Main St"
  };
}

+ (LULocation *)fullLocation {
  return [[LULocationJSONFactory factory] fromJSONObject:[self fullJSONObject]];
}

@end
