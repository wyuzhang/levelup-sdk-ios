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
#import "LUOrderAheadCompletedOrderItem.h"
#import "LUOrderAheadCompletedOrderJSONFactory.h"
#import "LUOrderAheadOrderConveyance.h"
#import "NSArray+LUAdditions.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUOrderAheadCompletedOrderJSONFactory

#pragma mark - LUAbstractJSONModelFactory Methods

- (id)createFromAttributes:(NSDictionary *)attributes {
  LUOrderAheadOrderConveyance *conveyance =
    [self conveyanceFromConveyanceJSON:[attributes lu_dictionaryForKey:@"conveyance"]];
  LUMonetaryValue *discount = [attributes lu_monetaryValueForKey:@"discount_amount"];
  NSString *instructions = [attributes lu_stringForKey:@"instructions"];
  NSArray *items = [self itemsFromItemsJSON:[attributes lu_arrayForKey:@"items"]];
  NSNumber *latitude = [attributes lu_numberForKey:@"latitude"];
  NSString *locationSubtitle = [attributes lu_stringForKey:@"location_subtitle"];
  NSString *locationTitle = [attributes lu_stringForKey:@"location_title"];
  NSNumber *longitude = [attributes lu_numberForKey:@"longitude"];
  NSString *orderNumber = [attributes lu_stringForKey:@"order_number"];
  NSString *phone = [attributes lu_stringForKey:@"phone"];
  NSDate *readyAt = [attributes lu_dateForKey:@"ready_at"];
  LUMonetaryValue *total = [attributes lu_monetaryValueForKey:@"total_amount"];

  return [[LUOrderAheadCompletedOrder alloc] initWithConveyance:conveyance
                                                       discount:discount
                                                   instructions:instructions
                                                          items:items
                                                       latitude:latitude
                                               locationSubtitle:locationSubtitle
                                                  locationTitle:locationTitle
                                                      longitude:longitude
                                                    orderNumber:orderNumber
                                                          phone:phone
                                                        readyAt:readyAt
                                                          total:total];
}

- (NSString *)rootKey {
  return @"order";
}

#pragma mark - Private Methods

- (LUOrderAheadOrderConveyance *)conveyanceFromConveyanceJSON:(NSDictionary *)conveyanceJSON {
  NSNumber *deliveryAddressID = [conveyanceJSON lu_numberForKey:@"delivery_address_id"];
  NSDate *desiredReadyTime = [conveyanceJSON lu_dateForKey:@"desired_ready_time"];
  LUOrderConveyanceFulfillmentType fulfillmentType =
    [LUOrderAheadOrderConveyance fulfillmentTypeFromString:[conveyanceJSON lu_stringForKey:@"fulfillment_type"]];

  return [[LUOrderAheadOrderConveyance alloc] initWithDeliveryAddressID:deliveryAddressID
                                                       desiredReadyTime:desiredReadyTime
                                                        fulfillmentType:fulfillmentType];
}

- (LUOrderAheadCompletedOrderItem *)itemFromItemJSON:(NSDictionary *)itemJSON {
  NSString *name = [itemJSON lu_stringForKey:@"name"];
  NSNumber *quantity = [itemJSON lu_numberForKey:@"quantity"];
  NSString *selectedOptionsDescription = [itemJSON lu_stringForKey:@"selected_options_description"];

  return [[LUOrderAheadCompletedOrderItem alloc] initWithName:name
                                                     quantity:quantity
                                   selectedOptionsDescription:selectedOptionsDescription];
}

- (NSArray *)itemsFromItemsJSON:(NSArray *)itemsJSON {
  return [itemsJSON lu_mappedArrayWithBlock:^LUOrderAheadCompletedOrderItem *(NSDictionary *itemJSON) {
    return [self itemFromItemJSON:[itemJSON lu_dictionaryForKey:@"item"]];
  }];
}

@end
