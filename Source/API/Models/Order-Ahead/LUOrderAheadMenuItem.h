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

#import "LUAPIModel.h"

@class LUMonetaryValue;

@interface LUOrderAheadMenuItem : LUAPIModel

@property (nonatomic, assign, readonly) NSUInteger displayOrder;
@property (nonatomic, strong, readonly) NSURL *imageURL;
@property (nonatomic, copy, readonly) NSString *itemDescription;
@property (nonatomic, copy, readonly) NSNumber *itemID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSDictionary *nutritionInfo;
@property (nonatomic, strong, readonly) NSArray *optionGroups;
@property (nonatomic, strong, readonly) LUMonetaryValue *price;
@property (nonatomic, strong, readonly) LUMonetaryValue *priceIncludingDefaultOptions;
@property (nonatomic, copy, readonly) NSString *SKU;
@property (nonatomic, copy, readonly) NSString *UPC;
@property (nonatomic, copy, readonly) NSUUID *UUID;

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
                                 UPC:(NSString *)UPC;

- (LUMonetaryValue *)priceIncludingOptionsWithIDs:(NSArray *)optionIDs;
- (LUOrderAheadMenuItem *)uniqueItem;
- (NSURL *)URLOfLargeImage;
- (NSURL *)URLOfMediumImage;
- (NSURL *)URLOfSmallImage;

@end
