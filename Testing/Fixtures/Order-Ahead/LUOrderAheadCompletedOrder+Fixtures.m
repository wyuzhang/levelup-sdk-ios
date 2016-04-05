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
#import "LUOrderAheadCompletedOrder+Fixtures.h"
#import "LUOrderAheadCompletedOrderItem+Fixtures.h"
#import "LUOrderAheadOrderConveyance.h"
#import "NSDate+StringFormats.h"

@implementation LUOrderAheadCompletedOrder (Fixtures)

+ (instancetype)fixture {
  return [self fixtureWithReadyAt:[NSDate lu_dateFromIso8601DateTimeString:@"2015-09-17T15:08:00Z"]];
}

+ (instancetype)fixtureWithOrderInstructions:(NSString *)orderInstructions {
  return [self fixtureWithOrderInstructions:orderInstructions
                                    readyAt:[NSDate lu_dateFromIso8601DateTimeString:@"2015-09-17T15:08:00Z"]];
}

+ (instancetype)fixtureWithOrderInstructions:(NSString *)orderInstructions readyAt:(NSDate *)readyAt {
  LUOrderAheadOrderConveyance *conveyance =
    [[LUOrderAheadOrderConveyance alloc] initWithDeliveryAddressID:nil
                                                  desiredReadyTime:[NSDate lu_dateFromIso8601DateTimeString:
                                                                    @"2015-09-17T15:00:00Z"]
                                                   fulfillmentType:LUOrderConveyanceFulfillmentTypePickup];

  return [[LUOrderAheadCompletedOrder alloc] initWithConveyance:conveyance
                                                       discount:[LUMonetaryValue monetaryValueWithUSCents:@100]
                                                   instructions:orderInstructions
                                                          items:@[[LUOrderAheadCompletedOrderItem fixture]]
                                                       latitude:@70
                                               locationSubtitle:@"Boston, MA 02114"
                                                  locationTitle:@"123 Main St."
                                                      longitude:@-45
                                                    orderNumber:@"1000432"
                                                          phone:@"6175551234"
                                                        readyAt:readyAt
                                                          total:[LUMonetaryValue monetaryValueWithUSCents:@945]];
}

+ (instancetype)fixtureWithReadyAt:(NSDate *)readyAt {
  return [self fixtureWithOrderInstructions:@"Pick up your food on the left side of the counter under the sign."
                                    readyAt:readyAt];
}

@end
