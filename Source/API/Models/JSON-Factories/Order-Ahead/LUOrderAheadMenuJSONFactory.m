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

#import "LUOrderAheadMenu.h"
#import "LUOrderAheadMenuCategory.h"
#import "LUOrderAheadMenuItem.h"
#import "LUOrderAheadMenuItemOption.h"
#import "LUOrderAheadMenuItemOptionGroup.h"
#import "LUOrderAheadMenuJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUOrderAheadMenuJSONFactory

#pragma mark - LUAbstractJSONModelFactory Methods

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSNumber *menuID = [attributes lu_numberForKey:@"id"];
  NSArray *categories = [self categoriesFromCategoriesJSON:[attributes lu_arrayForKey:@"categories"]];

  return [[LUOrderAheadMenu alloc] initWithCategories:categories menuID:menuID];
}

- (NSString *)rootKey {
  return @"menu";
}

#pragma mark - Private Methods

- (NSArray *)categoriesFromCategoriesJSON:(NSArray *)categoriesJSON {
  NSMutableArray *categories = [NSMutableArray array];

  for (id categoryJSON in categoriesJSON) {
    [categories addObject:[self categoryFromCategoryJSON:[categoryJSON lu_dictionaryForKey:@"category"]]];
  }

  return categories;
}

- (LUOrderAheadMenuCategory *)categoryFromCategoryJSON:(id)categoryJSON {
  NSNumber *categoryID = [categoryJSON lu_numberForKey:@"id"];
  NSString *name = [categoryJSON lu_stringForKey:@"name"];
  NSString *categoryDescription = [categoryJSON lu_stringForKey:@"description"];
  NSUInteger displayOrder = [[categoryJSON lu_numberForKey:@"display_order"] unsignedIntegerValue];
  NSArray *items = [self itemsFromItemsJSON:[categoryJSON lu_arrayForKey:@"items"]];

  return [[LUOrderAheadMenuCategory alloc] initWithCategoryDescription:categoryDescription
                                                            categoryID:categoryID
                                                          displayOrder:displayOrder
                                                                 items:items
                                                                  name:name];
}

- (LUOrderAheadMenuItem *)itemFromItemJSON:(id)itemJSON {
  NSNumber *itemID = [itemJSON lu_numberForKey:@"id"];
  NSString *name = [itemJSON lu_stringForKey:@"name"];
  NSString *itemDescription = [itemJSON lu_stringForKey:@"description"];
  NSUInteger displayOrder = [[itemJSON lu_numberForKey:@"display_order"] unsignedIntegerValue];
  LUMonetaryValue *price = [itemJSON lu_monetaryValueForKey:@"price_amount"];
  LUMonetaryValue *priceIncludingDefaultOptions = [itemJSON lu_monetaryValueForKey:@"price_with_defaults_amount"];
  NSURL *imageURL = [itemJSON lu_URLForKey:@"image_url"];
  NSDictionary *nutritionInfo = [itemJSON lu_dictionaryForKey:@"nutrition"];
  NSString *SKU = [itemJSON lu_stringForKey:@"sku"];
  NSString *UPC = [itemJSON lu_stringForKey:@"upc"];
  NSArray *optionGroups = [self optionGroupsFromOptionGroupsJSON:[itemJSON lu_arrayForKey:@"option_groups"]];

  return [[LUOrderAheadMenuItem alloc] initWithDisplayOrder:displayOrder
                                                   imageURL:imageURL
                                            itemDescription:itemDescription
                                                     itemID:itemID
                                                       name:name
                                              nutritionInfo:nutritionInfo
                                               optionGroups:optionGroups
                                                      price:price
                               priceIncludingDefaultOptions:priceIncludingDefaultOptions
                                                        SKU:SKU
                                                        UPC:UPC];
}

- (NSArray *)itemsFromItemsJSON:(NSArray *)itemsJSON {
  NSMutableArray *items = [NSMutableArray array];

  for (id itemJSON in itemsJSON) {
    [items addObject:[self itemFromItemJSON:[itemJSON lu_dictionaryForKey:@"item"]]];
  }

  return items;
}

- (LUOrderAheadMenuItemOption *)optionFromOptionJSON:(id)optionJSON {
  NSNumber *optionID = [optionJSON lu_numberForKey:@"id"];
  NSString *name = [optionJSON lu_stringForKey:@"name"];
  NSUInteger displayOrder = [[optionJSON lu_numberForKey:@"display_order"] unsignedIntegerValue];
  LUMonetaryValue *price = [optionJSON lu_monetaryValueForKey:@"price_amount"];

  return [[LUOrderAheadMenuItemOption alloc] initWithDisplayOrder:displayOrder
                                                             name:name
                                                         optionID:optionID
                                                            price:price];
}

- (LUOrderAheadMenuItemOptionGroup *)optionGroupFromOptionGroupJSON:(id)optionGroupJSON {
  NSNumber *optionGroupID = [optionGroupJSON lu_numberForKey:@"id"];
  NSString *name = [optionGroupJSON lu_stringForKey:@"name"];
  NSUInteger displayOrder = [[optionGroupJSON lu_numberForKey:@"display_order"] unsignedIntegerValue];
  NSNumber *minimumChoicesCount = [optionGroupJSON lu_numberForKey:@"minimum_choices"];
  NSNumber *maximumChoicesCount = [optionGroupJSON lu_numberForKey:@"maximum_choices"];
  NSNumber *freeChoicesCount = [optionGroupJSON lu_numberForKey:@"free_choices"];
  NSArray *defaultOptionIDs = [optionGroupJSON lu_arrayForKey:@"default_option_ids"];
  NSArray *options = [self optionsFromOptionsJSON:[optionGroupJSON lu_arrayForKey:@"options"]];

  return [[LUOrderAheadMenuItemOptionGroup alloc] initWithDefaultOptionIDs:defaultOptionIDs
                                                              displayOrder:displayOrder
                                                          freeChoicesCount:freeChoicesCount
                                                       maximumChoicesCount:maximumChoicesCount
                                                       minimumChoicesCount:minimumChoicesCount
                                                                      name:name
                                                             optionGroupID:optionGroupID
                                                                   options:options];
}

- (NSArray *)optionGroupsFromOptionGroupsJSON:(id)optionGroupsJSON {
  NSMutableArray *optionGroups = [NSMutableArray array];

  for (id optionGroupJSON in optionGroupsJSON) {
    [optionGroups addObject:
      [self optionGroupFromOptionGroupJSON:[optionGroupJSON lu_dictionaryForKey:@"option_group"]]];
  }

  return optionGroups;
}

- (NSArray *)optionsFromOptionsJSON:(NSArray *)optionsJSON {
  NSMutableArray *options = [NSMutableArray array];

  for (id optionJSON in optionsJSON) {
    [options addObject:[self optionFromOptionJSON:[optionJSON lu_dictionaryForKey:@"option"]]];
  }

  return options;
}

@end
