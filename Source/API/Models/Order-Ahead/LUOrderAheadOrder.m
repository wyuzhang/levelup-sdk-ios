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
#import "LUOrderAheadMenu.h"
#import "LUOrderAheadOrder.h"
#import "LUOrderAheadOrderConveyance.h"
#import "LUOrderAheadOrderItem.h"
#import "NSArray+LUAdditions.h"
#import "NSDate+StringFormats.h"
#import "NSDictionary+SafetyAdditions.h"

@implementation LUOrderAheadOrder

#pragma mark - Object Lifecycle Methods

- (instancetype)initWithConveyance:(LUOrderAheadOrderConveyance *)conveyance
                             items:(NSArray *)items
                        locationID:(NSNumber *)locationID
               specialInstructions:(NSString *)specialInstructions
                               tip:(LUMonetaryValue *)tip {
  self = [super init];
  if (!self) return nil;

  _conveyance = conveyance;
  _items = items;
  _locationID = locationID;
  _specialInstructions = specialInstructions;
  _tip = tip;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUOrderAheadOrder [address=%p, conveyance=%@, items=%@, locationID=%@, "
          "specialInstructions=%@, tip=%@]", self, self.conveyance, self.items, self.locationID,
          self.specialInstructions, self.tip];
}

#pragma mark - Public Methods

- (NSDictionary *)JSONDictionary {
  NSMutableDictionary *orderConveyanceJSONDict = [NSMutableDictionary dictionary];
  [orderConveyanceJSONDict lu_setSafeValue:self.conveyance.deliveryAddressID forKey:@"delivery_address_id"];
  [orderConveyanceJSONDict lu_setSafeValue:[self.conveyance.desiredReadyTime lu_iso8601DateTimeString]
                                    forKey:@"desired_ready_time"];
  NSString *fulfillmentTypeString =
    [LUOrderAheadOrderConveyance stringForFulfillmentType:self.conveyance.fulfillmentType];
  [orderConveyanceJSONDict lu_setSafeValue:fulfillmentTypeString forKey:@"fulfillment_type"];

  NSArray *orderItemsJSONArray = [self.items lu_mappedArrayWithBlock:^id(LUOrderAheadOrderItem *item) {
    NSMutableDictionary *orderItemPropertiesJSONDict = [NSMutableDictionary dictionary];
    [orderItemPropertiesJSONDict lu_setSafeValue:item.itemID forKey:@"id"];
    [orderItemPropertiesJSONDict lu_setSafeValue:item.quantity forKey:@"quantity"];
    [orderItemPropertiesJSONDict lu_setSafeValue:item.specialInstructions forKey:@"special_instructions"];
    [orderItemPropertiesJSONDict lu_setSafeValue:item.optionIDs forKey:@"option_ids"];

    return @{@"item": orderItemPropertiesJSONDict};
  }];

  NSMutableDictionary *orderPropertiesJSONDict = [NSMutableDictionary dictionary];
  [orderPropertiesJSONDict lu_setSafeValue:orderConveyanceJSONDict forKey:@"conveyance"];
  [orderPropertiesJSONDict lu_setSafeValue:orderItemsJSONArray forKey:@"items"];
  [orderPropertiesJSONDict lu_setSafeValue:self.locationID forKey:@"location_id"];
  [orderPropertiesJSONDict lu_setSafeValue:self.specialInstructions forKey:@"special_instructions"];
  [orderPropertiesJSONDict lu_setSafeValue:self.tip.amount forKey:@"tip_amount"];

  NSMutableDictionary *orderJSONDict = [NSMutableDictionary dictionary];
  [orderJSONDict lu_setSafeValue:orderPropertiesJSONDict forKey:@"order"];

  return orderJSONDict;
}

@end
