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
#import "LUOrderAheadMenuItemOptionGroup.h"
#import "NSArray+LUAdditions.h"

@implementation LUOrderAheadMenuItem

#pragma mark - Object Lifecycle Methods

- (instancetype)initWithDisplayOrder:(NSUInteger)displayOrder
                            imageURL:(NSURL *)imageURL
                     itemDescription:(NSString *)itemDescription
                              itemID:(NSNumber *)itemID
                                name:(NSString *)name
                       nutritionInfo:(NSDictionary *)nutritionInfo
                        optionGroups:(NSArray *)optionGroups
                               price:(LUMonetaryValue *)price
        priceIncludingDefaultOptions:(LUMonetaryValue *)priceIncludingDefaultOptions
                                 SKU:(NSString *)SKU
                                 UPC:(NSString *)UPC {
  self = [super init];
  if (!self) return nil;

  _itemID = itemID;
  _displayOrder = displayOrder;
  _imageURL = imageURL;
  _itemDescription = itemDescription;
  _name = name;
  _nutritionInfo = nutritionInfo;
  _optionGroups = optionGroups;
  _price = price;
  _priceIncludingDefaultOptions = priceIncludingDefaultOptions;
  _SKU = SKU;
  _UPC = UPC;
  _UUID = [NSUUID UUID];

  return self;
}

#pragma mark - Public Methods

- (LUMonetaryValue *)priceIncludingOptionsWithIDs:(NSArray *)optionIDs {
  return [self.price valueByAddingValue:[self priceOfOptionsWithIDs:optionIDs]];
}

- (LUOrderAheadMenuItem *)uniqueItem {
  return [[LUOrderAheadMenuItem alloc] initWithDisplayOrder:self.displayOrder
                                                   imageURL:self.imageURL
                                            itemDescription:self.itemDescription
                                                     itemID:self.itemID
                                                       name:self.name
                                              nutritionInfo:self.nutritionInfo
                                               optionGroups:self.optionGroups
                                                      price:self.price
                               priceIncludingDefaultOptions:self.priceIncludingDefaultOptions
                                                        SKU:self.SKU
                                                        UPC:self.UPC];
}

- (NSURL *)URLOfLargeImage {
  return [self imageURLWithHeight:300 width:420];
}

- (NSURL *)URLOfMediumImage {
  return [self imageURLWithHeight:180 width:320];
}

- (NSURL *)URLOfSmallImage {
  return [self imageURLWithHeight:92 width:133];
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUOrderAheadMenuItem [address=%p, displayOrder=%lu, imageURL=%@, "
          "itemDescription=%@, itemID=%@, name=%@, nutritionInfo=%@, optionGroups=%@, price=%@, "
          "priceIncludingDefaultOptions=%@, SKU=%@, UPC=%@, UUID=%@]", self, (unsigned long)self.displayOrder,
          self.imageURL, self.itemDescription, self.itemID, self.name, self.nutritionInfo, self.optionGroups,
          self.price, self.priceIncludingDefaultOptions, self.SKU, self.UPC, self.UUID];
}

#pragma mark - Private Methods

- (NSURL *)imageURLWithHeight:(int)height width:(int)width {
  NSString *path = [NSString stringWithFormat:@"%@?density=%d&height=%d&width=%d", self.imageURL.absoluteString,
                                              (int)[UIScreen mainScreen].scale, height, width];

  return [NSURL URLWithString:path];
}

- (LUMonetaryValue *)priceOfOptionsWithIDs:(NSArray *)optionIDs {
  return [LUMonetaryValue monetaryValueByAddingValues:
                            [self.optionGroups lu_mappedArrayWithBlock:
                                                 ^id(LUOrderAheadMenuItemOptionGroup *optionGroup) {
                                                   return [optionGroup priceOfOptionsWithIDs:optionIDs];
                                                 }]];
}

@end
