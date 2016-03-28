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

#import "LUOrderAheadOrderConveyance.h"
#import "LUOrderAheadOrderItem.h"
#import "LUOrderAheadSuggestedOrder.h"
#import "LUOrderAheadSuggestedOrderJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUOrderAheadSuggestedOrderJSONFactory

#pragma mark - LUAbstractJSONModelFactory Methods

- (id)createFromAttributes:(NSDictionary *)attributes {
  LUOrderAheadSuggestedOrderType banner = [LUOrderAheadSuggestedOrder orderTypeForString:
    [attributes lu_stringForKey:@"banner"]];
  NSDictionary *conveyanceDictionary = [attributes lu_dictionaryForKey:@"conveyance"];
  LUOrderConveyanceFulfillmentType conveyance = [LUOrderAheadOrderConveyance fulfillmentTypeFromString:
    [conveyanceDictionary objectForKey:@"fulfillment_type"]];
  NSDate *createdAtDate = [attributes lu_dateForKey:@"created_at"];
  NSArray *items = [self orderItemsFromItemsJSON:[attributes lu_arrayForKey:@"items"]];
  NSNumber *locationID = [attributes lu_numberForKey:@"location_id"];
  NSURL *menuURL = [attributes lu_URLForKey:@"menu_url"];
  NSString *merchantName = [attributes lu_stringForKey:@"merchant_name"];
  NSString *orderDescription = [attributes lu_stringForKey:@"description"];
  NSString *specialInstructions = [attributes lu_stringForKey:@"special_instructions"];
  LUMonetaryValue *totalAmount = [attributes lu_monetaryValueForKey:@"total_amount"];
  NSString *UUID = [attributes lu_stringForKey:@"uuid"];

  return [[LUOrderAheadSuggestedOrder alloc] initWithBanner:banner conveyance:conveyance createdAtDate:createdAtDate
                                                      items:items locationID:locationID menuURL:menuURL
                                               merchantName:merchantName orderDescription:orderDescription
                                        specialInstructions:specialInstructions totalAmount:totalAmount UUID:UUID];
}

- (NSString *)rootKey {
  return @"order";
}

#pragma mark - Private Methods

- (LUOrderAheadOrderItem *)itemFromItemJSON:(id)itemJSON {
  NSNumber *itemID = [itemJSON lu_numberForKey:@"id"];
  NSNumber *quantity = [itemJSON lu_numberForKey:@"quantity"];
  NSArray *optionIDs = [itemJSON lu_arrayForKey:@"option_ids"];
  NSString *specialInstructions = [itemJSON lu_stringForKey:@"special_instructions"];

  return [[LUOrderAheadOrderItem alloc] initWithItemID:itemID optionIDs:optionIDs quantity:quantity
                                   specialInstructions:specialInstructions];
}

- (NSArray *)orderItemsFromItemsJSON:(NSArray *)itemsJSON {
  NSMutableArray *items = [NSMutableArray array];

  for (id itemJSON in itemsJSON) {
    [items addObject:[self itemFromItemJSON:[itemJSON lu_dictionaryForKey:@"item"]]];
  }

  return items;
}

@end
