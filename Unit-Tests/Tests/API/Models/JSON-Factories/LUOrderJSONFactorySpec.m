/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "LUOrderJSONFactory.h"
#import "NSDate+StringFormats.h"

SPEC_BEGIN(LUOrderJSONFactorySpec)

describe(@"LUOrderJSONFactory", ^{
  __block LUOrderJSONFactory *factory;

  beforeEach(^{
    factory = [LUOrderJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUOrder", ^{
      NSDictionary *JSON = @{
        @"balance_amount" : @1000,
        @"bundle_closed_at" : @"2012-12-04T18:10:45-05:00",
        @"bundle_descriptor" : @"LevelUp",
        @"contribution_amount" : @50,
        @"contribution_target_name" : @"Test Charity",
        @"created_at" : @"2012-12-05T18:10:45-05:00",
        @"credit_applied_amount" : @100,
        @"credit_earned_amount" : @250,
        @"items": @[],
        @"location_extended_address" : @"Apt E",
        @"location_id" : @1,
        @"location_locality" : @"Boston",
        @"location_postal_code" : @"01234",
        @"location_region" : @"MA",
        @"location_street_address" : @"1 Main St",
        @"merchant_id" : @1,
        @"merchant_name" : @"Test Merchant",
        @"refunded_at" : @"2012-12-06T18:10:45-05:00",
        @"spend_amount" : @800,
        @"tip_amount" : @200,
        @"total_amount" : @1000,
        @"transacted_at" : @"2012-12-07T18:10:45-05:00",
        @"uuid" : @"abcd1234"
      };
      LUOrder *order = [factory createFromAttributes:JSON];

      [[order.balance should] equal:[LUMonetaryValue monetaryValueWithUSCents:@1000]];
      [[order.bundleClosedDate should] equal:[NSDate lu_dateFromIso8601DateTimeString:@"2012-12-04T18:10:45-05:00"]];
      [[order.bundleDescriptor should] equal:@"LevelUp"];
      [[order.contribution should] equal:[LUMonetaryValue monetaryValueWithUSCents:@50]];
      [[order.contributionTargetName should] equal:@"Test Charity"];
      [[order.createdDate should] equal:[NSDate lu_dateFromIso8601DateTimeString:@"2012-12-05T18:10:45-05:00"]];
      [[order.credit should] equal:[LUMonetaryValue monetaryValueWithUSCents:@100]];
      [[order.earn should] equal:[LUMonetaryValue monetaryValueWithUSCents:@250]];
      [[order.items should] equal:@[]];
      [[order.locationExtendedAddress should] equal:@"Apt E"];
      [[order.locationID should] equal:@1];
      [[order.locationLocality should] equal:@"Boston"];
      [[order.locationPostalCode should] equal:@"01234"];
      [[order.locationRegion should] equal:@"MA"];
      [[order.locationStreetAddress should] equal:@"1 Main St"];
      [[order.merchantID should] equal:@1];
      [[order.merchantName should] equal:@"Test Merchant"];
      [[order.refundedDate should] equal:[NSDate lu_dateFromIso8601DateTimeString:@"2012-12-06T18:10:45-05:00"]];
      [[order.spend should] equal:[LUMonetaryValue monetaryValueWithUSCents:@800]];
      [[order.tip should] equal:[LUMonetaryValue monetaryValueWithUSCents:@200]];
      [[order.total should] equal:[LUMonetaryValue monetaryValueWithUSCents:@1000]];
      [[order.transactedDate should] equal:[NSDate lu_dateFromIso8601DateTimeString:@"2012-12-07T18:10:45-05:00"]];
      [[order.UUID should] equal:@"abcd1234"];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'order'", ^{
      [[[factory rootKey] should] equal:@"order"];
    });
  });
});

SPEC_END
