#import "LUUserAddress+Fixtures.h"
#import "LUUserAddressJSONFactory.h"

@implementation LUUserAddress (Fixtures)

+ (NSDictionary *)fullJSONObject {
  return @{
    @"address_type" : @"home",
    @"extended_address" : @"Apt E",
    @"id" : @1,
    @"locality" : @"Boston",
    @"postal_code" : @"01234",
    @"region" : @"MA",
    @"street_address" : @"1 Main St"
  };
}

+ (LUUserAddress *)fullUserAddress {
  return [[LUUserAddressJSONFactory factory] fromJSONObject:[self fullJSONObject]];
}

@end
