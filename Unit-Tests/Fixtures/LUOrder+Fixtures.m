// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUOrder+Fixtures.h"
#import "LUOrderJSONFactory.h"

@implementation LUOrder (Fixtures)

+ (NSDictionary *)fullJSONObject {
  return @{
    @"balance_amount" : @1000,
    @"bundle_closed_at" : [[NSDate fixture] lu_iso8601DateTimeString],
    @"bundle_descriptor" : @"LevelUp",
    @"contribution_amount" : @50,
    @"contribution_target_name" : @"Test Charity",
    @"created_at" : [[NSDate fixture] lu_iso8601DateTimeString],
    @"credit_applied_amount" : @100,
    @"credit_earned_amount" : @250,
    @"location_extended_address" : @"Apt E",
    @"location_id" : @1,
    @"location_locality" : @"Boston",
    @"location_postal_code" : @"01234",
    @"location_region" : @"MA",
    @"location_street_address" : @"1 Main St",
    @"merchant_id" : @1,
    @"merchant_name" : @"Test Merchant",
    @"refunded_at" : [[NSDate fixture] lu_iso8601DateTimeString],
    @"spend_amount" : @800,
    @"tip_amount" : @200,
    @"total_amount" : @1000,
    @"transacted_at" : [[NSDate fixture] lu_iso8601DateTimeString],
    @"uuid" : @"abcd1234"
  };
}

+ (LUOrder *)fullOrder {
  return [[LUOrderJSONFactory factory] fromJSONObject:[self fullJSONObject]];
}

@end
