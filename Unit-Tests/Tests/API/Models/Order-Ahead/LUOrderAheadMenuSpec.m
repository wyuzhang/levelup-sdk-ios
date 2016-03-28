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

SPEC_BEGIN(LUOrderAheadMenuSpec)

describe(@"LUOrderAheadMenu", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUOrderAheadMenu class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Object Lifecycle Methods

  describe(@"initWithCategories:menuID:", ^{
    __block NSArray *categories;

    beforeEach(^{
      LUOrderAheadMenuCategory *category1 = [LUOrderAheadMenuCategory nullMock];
      LUOrderAheadMenuCategory *category2 = [LUOrderAheadMenuCategory nullMock];
      LUOrderAheadMenuCategory *category3 = [LUOrderAheadMenuCategory nullMock];

      [category1 stub:@selector(displayOrder) andReturn:theValue(0)];
      [category2 stub:@selector(displayOrder) andReturn:theValue(1)];
      [category3 stub:@selector(displayOrder) andReturn:theValue(2)];

      categories = @[category3, category2, category1];
    });

    it(@"sorts the categories by their display order", ^{
      LUOrderAheadMenu *menu = [[LUOrderAheadMenu alloc] initWithCategories:categories menuID:@1];

      [[menu.categories[0] should] equal:categories[2]];
      [[menu.categories[1] should] equal:categories[1]];
      [[menu.categories[2] should] equal:categories[0]];
    });
  });

  // Public Methods

  describe(@"categoryNames", ^{
    LUOrderAheadMenu *menu = [LUOrderAheadMenu fixture];

    it(@"returns the names of the menu's categories in order", ^{
      [[[menu categoryNames] should] equal:@[@"Appetizers", @"Lunch", @"Drinks"]];
    });
  });

  describe(@"menuItemWithID:", ^{
    it(@"finds and returns the menu item with matching ID from its categories", ^{
      LUOrderAheadMenuItem *menuItem = [LUOrderAheadMenuItem fixture];
      LUOrderAheadMenuCategory *category = [[LUOrderAheadMenuCategory alloc]
        initWithCategoryDescription:nil categoryID:@1 displayOrder:1 items:@[menuItem] name:nil];
      LUOrderAheadMenu *menu = [[LUOrderAheadMenu alloc] initWithCategories:@[category] menuID:@1];

      [[[menu menuItemWithID:menuItem.itemID] should] equal:menuItem];
    });
  });
});

SPEC_END
