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

#import "LUOrderAheadMenuItemOption.h"

@implementation LUOrderAheadMenuItemOption

#pragma mark - Object Lifecycle Methods

- (instancetype)initWithDisplayOrder:(NSUInteger)displayOrder
                                name:(NSString *)name
                            optionID:(NSNumber *)optionID
                               price:(LUMonetaryValue *)price {
  self = [super init];
  if (!self) return nil;

  _optionID = optionID;
  _displayOrder = displayOrder;
  _name = name;
  _price = price;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUOrderAheadMenuItemOption [address=%p, displayOrder=%lu, name=%@, optionID=%@, "
          "price=%@]", self, (unsigned long)self.displayOrder, self.name, self.optionID, self.price];
}

@end
