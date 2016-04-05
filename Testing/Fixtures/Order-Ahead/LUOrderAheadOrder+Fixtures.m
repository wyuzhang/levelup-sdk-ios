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
#import "LUOrderAheadMenuItem.h"
#import "LUOrderAheadMenuItemOption.h"
#import "LUOrderAheadOrder+Fixtures.h"
#import "LUOrderAheadOrderConveyance+Fixtures.h"
#import "LUOrderAheadOrderItem+Fixtures.h"
#import "NSArray+LUAdditions.h"

@implementation LUOrderAheadOrder (Fixtures)

+ (instancetype)fixture {
  return [[LUOrderAheadOrder alloc] initWithConveyance:[LUOrderAheadOrderConveyance fixture]
                                                 items:@[[LUOrderAheadOrderItem fixture]]
                                            locationID:@1
                                   specialInstructions:nil
                                                   tip:nil];
}

+ (instancetype)fixtureForDefaultOrder {
  LUOrderAheadOrder *defaultOrder =
    [[LUOrderAheadOrder alloc] initWithConveyance:[LUOrderAheadOrderConveyance fixtureForDefaultConveyance]
                                            items:@[]
                                       locationID:nil
                              specialInstructions:nil
                                              tip:[LUMonetaryValue monetaryValueWithUSCents:@0]];
  return defaultOrder;
}

+ (instancetype)fixtureForDefaultOrderWithLocationID:(NSNumber *)locationID {
  return [[LUOrderAheadOrder alloc] initWithConveyance:[self fixtureForDefaultOrder].conveyance
                                                 items:[self fixtureForDefaultOrder].items
                                            locationID:locationID
                                   specialInstructions:[self fixtureForDefaultOrder].specialInstructions
                                                   tip:[self fixtureForDefaultOrder].tip];
}

+ (instancetype)fixtureForOrderWithConveyanceFulfillmentType:(LUOrderConveyanceFulfillmentType)type {
  return [[LUOrderAheadOrder alloc] initWithConveyance:[LUOrderAheadOrderConveyance fixtureWithFulfillmentType:type]
                                                 items:[self fixtureForDefaultOrder].items
                                            locationID:[self fixtureForDefaultOrder].locationID
                                   specialInstructions:[self fixtureForDefaultOrder].specialInstructions
                                                   tip:[self fixtureForDefaultOrder].tip];
}

+ (instancetype)fixtureWithCartItems:(NSArray *)cartItems locationID:(NSNumber *)locationID {
  return [[LUOrderAheadOrder alloc] initWithConveyance:[self fixtureForDefaultOrder].conveyance
                                                 items:cartItems
                                            locationID:locationID
                                   specialInstructions:[self fixtureForDefaultOrder].specialInstructions
                                                   tip:[self fixtureForDefaultOrder].tip];
}

@end
