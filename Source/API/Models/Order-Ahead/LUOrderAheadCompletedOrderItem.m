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

#import "LUOrderAheadCompletedOrderItem.h"

@implementation LUOrderAheadCompletedOrderItem

#pragma mark - Object Lifecycle Methods

- (instancetype)initWithName:(NSString *)name
                    quantity:(NSNumber *)quantity
  selectedOptionsDescription:(NSString *)selectedOptionsDescription {
  self = [super init];
  if (!self) return nil;

  _name = name;
  _quantity = quantity;
  _selectedOptionsDescription = selectedOptionsDescription;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUOrderAheadCompletedOrderItem [address=%p, name=%@, quantity=%@, "
          "selectedOptionsDescription=%@]", self, self.name, self.quantity, self.selectedOptionsDescription];
}

@end
