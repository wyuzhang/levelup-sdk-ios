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

#import "LUOrderAheadOrderItem.h"

@implementation LUOrderAheadOrderItem

#pragma mark - Object Lifecycle Methods

- (instancetype)initWithItemID:(NSNumber *)itemID
                     optionIDs:(NSArray *)optionIDs
                      quantity:(NSNumber *)quantity
           specialInstructions:(NSString *)specialInstructions {
  self = [super init];
  if (!self) return nil;

  _itemID = itemID;
  _optionIDs = optionIDs;
  _quantity = quantity;
  _specialInstructions = specialInstructions;
  _UUID = [NSUUID UUID];

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUOrderAheadOrderItem [address=%p, itemID=%@, optionIDs=%@, quantity=%@, "
          "specialInstructions=%@, UUID=%@]", self, self.itemID, self.optionIDs, self.quantity,
          self.specialInstructions, self.UUID];
}

@end
