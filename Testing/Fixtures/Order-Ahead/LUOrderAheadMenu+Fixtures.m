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

#import "LUOrderAheadMenu+Fixtures.h"
#import "LUOrderAheadMenuCategory.h"
#import "LUOrderAheadMenuItem+Fixtures.h"

@implementation LUOrderAheadMenu (Fixtures)

+ (LUOrderAheadMenu *)fixture {
  return [[LUOrderAheadMenu alloc] initWithCategories:@[[self category1], [self category2], [self category3]]
                                               menuID:@1];
}

#pragma mark - Private Methods

+ (LUOrderAheadMenuCategory *)category1 {
  return [[LUOrderAheadMenuCategory alloc]
          initWithCategoryDescription:@"Small dishes to share while you wait for the main course."
          categoryID:@1
          displayOrder:1
          items:@[[LUOrderAheadMenuItem fixtureForTaterTotsItem]]
          name:@"Appetizers"];
}

+ (LUOrderAheadMenuCategory *)category2 {
  return [[LUOrderAheadMenuCategory alloc]
          initWithCategoryDescription:nil
          categoryID:@2
          displayOrder:2
          items:@[[LUOrderAheadMenuItem fixtureForBurritoItem]]
          name:@"Lunch"];
}

+ (LUOrderAheadMenuCategory *)category3 {
  return [[LUOrderAheadMenuCategory alloc]
          initWithCategoryDescription:nil
          categoryID:@3
          displayOrder:3
          items:@[[LUOrderAheadMenuItem fixtureForWaterItem],
                  [LUOrderAheadMenuItem fixtureForBeerItem]]
          name:@"Drinks"];
}

@end
