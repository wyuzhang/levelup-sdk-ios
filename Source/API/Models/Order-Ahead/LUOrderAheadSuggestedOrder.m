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

#import "LUOrderAheadSuggestedOrder.h"

@implementation LUOrderAheadSuggestedOrder

#pragma mark - Initialization Methods

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
                          UUID:(NSString *)UUID {
  self = [super init];
  if (!self) return nil;

  _banner = banner;
  _conveyance = conveyance;
  _createdAtDate = createdAtDate;
  _items = items;
  _locationID = locationID;
  _menuURL = menuURL;
  _merchantName = merchantName;
  _orderDescription = orderDescription;
  _specialInstructions = specialInstructions;
  _totalAmount = totalAmount;
  _UUID = UUID;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUOrderAheadSuggestedOrder [address=%p, banner=%@, conveyance=%@, "
          "createdAtDate=%@, items=%@, locationID=%@, menuURL=%@, merchantName=%@," "orderDescription=%@, "
          "specialInstructions=%@, totalAmount=%@, UUID=%@]", self,
          [LUOrderAheadSuggestedOrder stringForOrderType:self.banner], self.conveyance, self.createdAtDate, self.items,
          self.locationID, self.menuURL, self.merchantName, self.orderDescription, self.specialInstructions,
          self.totalAmount, self.UUID];
}

#pragma mark - Public Methods

+ (LUOrderAheadSuggestedOrderType)orderTypeForString:(NSString *)string {
  if ([string isEqualToString:@"past"]) {
    return LUOrderAheadSuggestedOrderTypePast;
  } else {
    return LUOrderAheadSuggestedOrderTypePopular;
  }
}

+ (NSString *)stringForOrderType:(LUOrderAheadSuggestedOrderType)orderType {
  switch (orderType) {
    case LUOrderAheadSuggestedOrderTypePast:
      return @"past";
    case LUOrderAheadSuggestedOrderTypePopular:
      return @"popular";
  }
}

@end
