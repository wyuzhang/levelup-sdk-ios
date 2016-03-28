/*
 * Copyright (C) 2016 SCVNGR, Inc. d/b/a LevelUp
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

#import "LUMonetaryValue.h"
#import "LUOrderAheadMenuItem+Fixtures.h"
#import "LUOrderAheadOrderItem+Fixtures.h"
#import "LUOrderAheadSuggestedOrder+Fixtures.h"
#import "NSDate+StringFormats.h"

@implementation LUOrderAheadSuggestedOrder (Fixtures)

+ (instancetype)fixture {
  NSDate *createdAtDate =
    [[NSDate lu_dateFromIso8601DateTimeString:@"2015-09-17T15:00:00Z"]
     lu_dateAfterConvertingToTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EST"]];

  return [[LUOrderAheadSuggestedOrder alloc]
          initWithBanner:LUOrderAheadSuggestedOrderTypePast
          conveyance:LUOrderConveyanceFulfillmentTypePickup
          createdAtDate:createdAtDate
          items:@[[LUOrderAheadOrderItem fixture], [LUOrderAheadOrderItem fixture]]
          locationID:@1 menuURL:[NSURL URLWithString:@"www.example.com/pickup"]
          merchantName:@"Test Merchant"
          orderDescription:@"Description"
          specialInstructions:@"Special Instructions"
          totalAmount:[LUMonetaryValue monetaryValueWithUSCents:@1000] UUID:@"1"];
}

@end
