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

SPEC_BEGIN(LUOrderAheadMenuCategorySpec)

describe(@"LUOrderAheadMenuCategory", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUOrderAheadMenuCategory class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  describe(@"initWithCategoryDescription:categoryID:displayOrder:items:name:", ^{
    __block NSArray *items;

    beforeEach(^{
      LUOrderAheadMenuItem *item1 = [LUOrderAheadMenuItem nullMock];
      LUOrderAheadMenuItem *item2 = [LUOrderAheadMenuItem nullMock];
      LUOrderAheadMenuItem *item3 = [LUOrderAheadMenuItem nullMock];

      [item1 stub:@selector(displayOrder) andReturn:theValue(0)];
      [item2 stub:@selector(displayOrder) andReturn:theValue(1)];
      [item3 stub:@selector(displayOrder) andReturn:theValue(2)];

      items = @[item3, item2, item1];
    });

    it(@"sorts the items by their display order", ^{
      LUOrderAheadMenuCategory *category = [[LUOrderAheadMenuCategory alloc] initWithCategoryDescription:@""
                                                                                              categoryID:@1
                                                                                            displayOrder:0
                                                                                                   items:items
                                                                                                    name:@""];
      [[category.items[0] should] equal:items[2]];
      [[category.items[1] should] equal:items[1]];
      [[category.items[2] should] equal:items[0]];
    });
  });
});

SPEC_END
