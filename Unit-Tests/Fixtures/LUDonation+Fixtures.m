#import "LUDonation+Fixtures.h"
#import "LUDonationJSONFactory.h"

@implementation LUDonation (Fixtures)

+ (LUDonation *)fullDonation {
  return [[LUDonationJSONFactory factory] fromJSONObject:[self fullJSONObject]];
}

+ (NSDictionary *)fullJSONObject {
  return @{
    @"cause": [LUCause fullJSONObject],
    @"id" : @1,
    @"value" : [LUMonetaryValue fullJSONObject]
  };
}

@end
