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

#import "LUOrderAheadCompletedOrder.h"
#import "LUOrderAheadCompletedOrderJSONFactory.h"
#import "LUOrderAheadOrderConveyance.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUOrderAheadCompletedOrderJSONFactory

#pragma mark - LUAbstractJSONModelFactory Methods

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSDictionary *conveyanceJSON = [attributes lu_dictionaryForKey:@"conveyance"];
  NSString *fulfillmentTypeString = [conveyanceJSON lu_stringForKey:@"fulfillment_type"];
  LUOrderConveyanceFulfillmentType fulfillmentType =
    [LUOrderAheadOrderConveyance fulfillmentTypeFromString:fulfillmentTypeString];
  NSNumber *deliveryAddressID = [conveyanceJSON lu_numberForKey:@"delivery_address_id"];
  NSDate *desiredReadyTime = [conveyanceJSON lu_dateForKey:@"desired_ready_time"];
  LUOrderAheadOrderConveyance *conveyance =
    [[LUOrderAheadOrderConveyance alloc] initWithDeliveryAddressID:deliveryAddressID
                                                  desiredReadyTime:desiredReadyTime
                                                   fulfillmentType:fulfillmentType];
  LUMonetaryValue *discount = [attributes lu_monetaryValueForKey:@"discount_amount"];
  NSString *instructions = [attributes lu_stringForKey:@"instructions"];
  NSNumber *orderLocationID = [attributes lu_numberForKey:@"location_id"];
  NSString *orderNumber = [attributes lu_stringForKey:@"order_number"];
  NSDate *readyAt = [attributes lu_dateForKey:@"ready_at"];
  LUMonetaryValue *total = [attributes lu_monetaryValueForKey:@"total_amount"];

  return [[LUOrderAheadCompletedOrder alloc] initWithConveyance:conveyance
                                                       discount:discount
                                                   instructions:instructions
                                                orderLocationID:orderLocationID
                                                    orderNumber:orderNumber
                                                        readyAt:readyAt
                                                          total:total];
}

- (NSString *)rootKey {
  return @"order";
}

@end
