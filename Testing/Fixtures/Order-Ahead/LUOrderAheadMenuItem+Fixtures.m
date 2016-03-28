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
#import "LUOrderAheadMenuItemOptionGroup+Fixtures.h"

@implementation LUOrderAheadMenuItem (Fixtures)

+ (instancetype)fixture {
  return [self fixtureForTaterTotsItem];
}

+ (instancetype)fixtureForBeerItem {
  return [[LUOrderAheadMenuItem alloc]
          initWithDisplayOrder:2
          imageURL:[NSURL URLWithString:@"https://levelup-order-ahead-staging.herokuapp.com/v15/menus/3/items/4/image"]
          itemDescription:@"Widely available in California!"
          itemID:@4
          name:@"Beer"
          nutritionInfo:@{@"calories": @"140"}
          optionGroups:@[]
          price:[LUMonetaryValue monetaryValueWithUSCents:@615]
          priceIncludingDefaultOptions:[LUMonetaryValue monetaryValueWithUSCents:@615]
          SKU:@"3AC7098F"
          UPC:nil];
}

+ (instancetype)fixtureForBurritoItem {
  return [[LUOrderAheadMenuItem alloc]
          initWithDisplayOrder:1
          imageURL:nil
          itemDescription:@"A food torpedo."
          itemID:@2
          name:@"Burrito"
          nutritionInfo:@{@"calories": @"640"}
          optionGroups:@[[LUOrderAheadMenuItemOptionGroup fixtureForFillingOptionGroup],
                         [LUOrderAheadMenuItemOptionGroup fixtureForToppingsOptionGroup],
                         [LUOrderAheadMenuItemOptionGroup fixtureForTortillaOptionGroup],
                         [LUOrderAheadMenuItemOptionGroup fixtureForSalsaOptionGroup],
                         [LUOrderAheadMenuItemOptionGroup fixtureForNachoComboOptionGroup]]
          price:[LUMonetaryValue monetaryValueWithUSCents:@699]
          priceIncludingDefaultOptions:[LUMonetaryValue monetaryValueWithUSCents:@699]
          SKU:@"2EC6DC79"
          UPC:nil];
}

+ (instancetype)fixtureForTacoItem {
  return [[LUOrderAheadMenuItem alloc]
          initWithDisplayOrder:1
          imageURL:[NSURL URLWithString:@"https://levelup-order-ahead-staging.herokuapp.com/v15/menus/3/items/1/image"]
          itemDescription:@"Try our brand new tacos!"
          itemID:@1
          name:@"Taco"
          nutritionInfo:@{@"calories": @"300"}
          optionGroups:@[[LUOrderAheadMenuItemOptionGroup fixtureForFillingOptionGroup]]
          price:[LUMonetaryValue monetaryValueWithUSCents:@299]
          priceIncludingDefaultOptions:[LUMonetaryValue monetaryValueWithUSCents:@299]
          SKU:@"5586F636"
          UPC:nil];
}

+ (instancetype)fixtureForTaterTotsItem {
  return [[LUOrderAheadMenuItem alloc]
          initWithDisplayOrder:1
          imageURL:[NSURL URLWithString:@"https://levelup-order-ahead-staging.herokuapp.com/v15/menus/3/items/1/image"]
          itemDescription:@"Try our tots!"
          itemID:@1
          name:@"Tater Tots"
          nutritionInfo:@{@"calories": @"390"}
          optionGroups:@[[LUOrderAheadMenuItemOptionGroup fixtureForAppetizerSizeOptionGroup]]
          price:[LUMonetaryValue monetaryValueWithUSCents:@299]
          priceIncludingDefaultOptions:[LUMonetaryValue monetaryValueWithUSCents:@398]
          SKU:@"5586F636"
          UPC:nil];
}

+ (instancetype)fixtureForWaterItem {
  return [[LUOrderAheadMenuItem alloc]
          initWithDisplayOrder:1
          imageURL:nil
          itemDescription:@"Not available in California."
          itemID:@3
          name:@"Water"
          nutritionInfo:@{@"calories": @"0"}
          optionGroups:@[]
          price:[LUMonetaryValue monetaryValueWithUSCents:@349]
          priceIncludingDefaultOptions:[LUMonetaryValue monetaryValueWithUSCents:@349]
          SKU:@"EE703FCC"
          UPC:nil];
}

+ (instancetype)fixtureForUniqueItemFromItem:(LUOrderAheadMenuItem *)item {
  return [[LUOrderAheadMenuItem alloc] initWithDisplayOrder:item.displayOrder
                                                   imageURL:item.imageURL
                                            itemDescription:item.itemDescription
                                                     itemID:item.itemID
                                                       name:item.name
                                              nutritionInfo:item.nutritionInfo
                                               optionGroups:item.optionGroups
                                                      price:item.price
                               priceIncludingDefaultOptions:[LUMonetaryValue monetaryValueWithUSCents:@0]
                                                        SKU:item.SKU
                                                        UPC:item.UPC];
}

@end
