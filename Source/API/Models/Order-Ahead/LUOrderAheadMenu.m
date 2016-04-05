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

#import "LUOrderAheadMenu.h"
#import "LUOrderAheadMenuCategory.h"
#import "LUOrderAheadMenuItem.h"
#import "LUOrderAheadOrderItem.h"
#import "NSArray+LUAdditions.h"

@implementation LUOrderAheadMenu

#pragma mark - Object Lifecycle Methods

- (instancetype)initWithCategories:(NSArray *)categories menuID:(NSNumber *)menuID {
  self = [super init];
  if (!self) return nil;

  _categories =
    [categories sortedArrayUsingComparator:
                  ^NSComparisonResult(LUOrderAheadMenuCategory *category1, LUOrderAheadMenuCategory *category2) {
                    return [@(category1.displayOrder) compare:@(category2.displayOrder)];
                  }];

  _menuID = menuID;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUOrderMenu [address=%p, categories=%@, menuID=%@]", self, self.categories,
          self.menuID];
}

#pragma mark - Public Methods

- (NSArray *)categoryNames {
  return [self.categories lu_mappedArrayWithBlock:^id(LUOrderAheadMenuCategory *category) {
    return category.name;
  }];
}

- (LUOrderAheadMenuItem *)menuItemWithID:(NSNumber *)menuItemID {
  for (LUOrderAheadMenuCategory *category in self.categories) {
    for (LUOrderAheadMenuItem *item in category.items) {
      if ([item.itemID isEqual:menuItemID]) {
        return item;
      }
    }
  }

  return nil;
}

@end
