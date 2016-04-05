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
@class LUOrderAheadOrderConveyance;

@interface LUOrderAheadSuggestedOrder : LUAPIModel

typedef NS_ENUM(NSInteger, LUOrderAheadSuggestedOrderType) {
  LUOrderAheadSuggestedOrderTypePast,
  LUOrderAheadSuggestedOrderTypePopular
};

@property (nonatomic, assign, readonly) LUOrderAheadSuggestedOrderType banner;
@property (nonatomic, strong, readonly) LUOrderAheadOrderConveyance *conveyance;
@property (nonatomic, copy, readonly) NSDate *createdAtDate;
@property (nonatomic, strong, readonly) NSArray *items;
@property (nonatomic, assign, readonly) NSNumber *locationID;
@property (nonatomic, copy, readonly) NSURL *menuURL;
@property (nonatomic, copy, readonly) NSString *merchantName;
@property (nonatomic, copy, readonly) NSString *orderDescription;
@property (nonatomic, copy, readonly) NSString *specialInstructions;
@property (nonatomic, strong, readonly) LUMonetaryValue *totalAmount;
@property (nonatomic, copy, readonly) NSString *UUID;

+ (LUOrderAheadSuggestedOrderType)orderTypeForString:(NSString *)string;
+ (NSString *)stringForOrderType:(LUOrderAheadSuggestedOrderType)orderType;

- (instancetype)initWithBanner:(LUOrderAheadSuggestedOrderType)banner
                    conveyance:(LUOrderAheadOrderConveyance *)conveyance
                 createdAtDate:(NSDate *)createdAtDate
                         items:(NSArray *)items
                    locationID:(NSNumber *)locationID
                       menuURL:(NSURL *)menuURL
                  merchantName:(NSString *)merchantName
              orderDescription:(NSString *)orderDescription
           specialInstructions:(NSString *)specialInstructions
                   totalAmount:(LUMonetaryValue *)totalAmount
                          UUID:(NSString *)UUID;

@end
