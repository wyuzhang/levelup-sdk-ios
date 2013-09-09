// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUCreditCard+Fixtures.h"

@implementation LUCreditCard (Fixtures)

+ (NSDictionary *)fullJSONObject {
  return @{
    @"description": @"description",
    @"id" : @1,
    @"expiration_month" : @11,
    @"expiration_year" : @13,
    @"last_4" : @"1234",
    @"promoted" : @YES,
    @"type" : @"visa"
  };
}

@end
