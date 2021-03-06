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

typedef NS_ENUM(NSInteger, LUOrderConveyanceFulfillmentType) {
  LUOrderConveyanceFulfillmentTypeUnknown,
  LUOrderConveyanceFulfillmentTypeDelivery,
  LUOrderConveyanceFulfillmentTypePickup
};

@interface LUOrderAheadOrderConveyance : LUAPIModel

@property (nonatomic, copy, readonly) NSNumber *deliveryAddressID;
@property (nonatomic, strong, readonly) NSDate *desiredReadyTime;
@property (nonatomic, assign, readonly) LUOrderConveyanceFulfillmentType fulfillmentType;

- (instancetype)initWithDeliveryAddressID:(NSNumber *)deliveryAddressID
                         desiredReadyTime:(NSDate *)desiredReadyTime
                          fulfillmentType:(LUOrderConveyanceFulfillmentType)fulfillmentType;

+ (LUOrderConveyanceFulfillmentType)fulfillmentTypeFromString:(NSString *)fulfillmentTypeString;
+ (NSString *)stringForFulfillmentType:(LUOrderConveyanceFulfillmentType)fulfillmentType;

@end
