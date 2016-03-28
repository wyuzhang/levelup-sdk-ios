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

#import "LUOrderAheadMenuCategory.h"
#import "LUOrderAheadMenuItem.h"

@implementation LUOrderAheadMenuCategory

#pragma mark - Object Lifecycle Methods

- (instancetype)initWithCategoryDescription:(NSString *)categoryDescription
                                 categoryID:(NSNumber *)categoryID
                               displayOrder:(NSUInteger)displayOrder
                                      items:(NSArray *)items
                                       name:(NSString *)name {
  self = [super init];
  if (!self) return nil;

  _categoryDescription = categoryDescription;
  _categoryID = categoryID;
  _displayOrder = displayOrder;
  _items =
    [items sortedArrayUsingComparator:^NSComparisonResult(LUOrderAheadMenuItem *item1, LUOrderAheadMenuItem *item2) {
      return [@(item1.displayOrder) compare:@(item2.displayOrder)];
    }];
  _name = name;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUOrderMenuCategory [address=%p, categoryDescription=%@, categoryID=%@,"
          "displayOrder=%lu, items=%@, name=%@]", self, self.categoryDescription, self.categoryID,
          (unsigned long)self.displayOrder, self.items, self.name];
}

@end
