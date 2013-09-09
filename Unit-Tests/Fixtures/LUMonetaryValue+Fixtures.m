// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUMonetaryValue+Fixtures.h"
#import "LUMonetaryValueJSONFactory.h"

@implementation LUMonetaryValue (Fixtures)

+ (NSDictionary *)fullJSONObject {
  return @{
    @"amount" : @1000,
    @"currency_code" : @"USD",
    @"currency_symbol" : @"$",
    @"formatted_amount" : @"10.00"
  };
}

+ (LUMonetaryValue *)fullMonetaryValue {
  return [[LUMonetaryValueJSONFactory factory] fromJSONObject:[self fullJSONObject]];
}

@end
