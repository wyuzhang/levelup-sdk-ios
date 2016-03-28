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

@implementation LUOrderAheadOrderConveyance

#pragma mark - Object Lifecycle Methods

- (instancetype)initWithDeliveryAddressID:(NSNumber *)deliveryAddressID
                         desiredReadyTime:(NSDate *)desiredReadyTime
                          fulfillmentType:(LUOrderConveyanceFulfillmentType)fulfillmentType {
  self = [super init];
  if (!self) return nil;

  _deliveryAddressID = deliveryAddressID;
  _desiredReadyTime = desiredReadyTime;
  _fulfillmentType = fulfillmentType;

  return self;
}

#pragma mark - Public Methods

+ (LUOrderConveyanceFulfillmentType)fulfillmentTypeFromString:(NSString *)fulfillmentTypeString {
  if ([fulfillmentTypeString isEqual:@"unknown"]) {
    return LUOrderConveyanceFulfillmentTypeUnknown;
  }

  if ([fulfillmentTypeString isEqual:@"delivery"]) {
    return LUOrderConveyanceFulfillmentTypeDelivery;
  }

  return LUOrderConveyanceFulfillmentTypePickup;
}

+ (NSString *)stringForFulfillmentType:(LUOrderConveyanceFulfillmentType)fulfillmentType {
  switch (fulfillmentType) {
    case LUOrderConveyanceFulfillmentTypeUnknown:
      return @"unknown";
    case LUOrderConveyanceFulfillmentTypeDelivery:
      return @"delivery";
    case LUOrderConveyanceFulfillmentTypePickup:
      return @"pickup";
  }
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUOrderAheadOrderConveyance [address=%p, deliveryAddressID=%@, "
          "desiredReadyTime=%@, fulfillmentType=%@]", self, self.deliveryAddressID, self.desiredReadyTime,
          [LUOrderAheadOrderConveyance stringForFulfillmentType:self.fulfillmentType]];
}

@end
