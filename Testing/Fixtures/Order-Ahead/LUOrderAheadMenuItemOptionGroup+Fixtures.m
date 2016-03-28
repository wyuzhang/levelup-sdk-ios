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

#import "LUOrderAheadMenuItemOption+Fixtures.h"
#import "LUOrderAheadMenuItemOptionGroup+Fixtures.h"

@implementation LUOrderAheadMenuItemOptionGroup (Fixtures)

+ (LUOrderAheadMenuItemOptionGroup *)fixture {
  return [self fixtureForFillingOptionGroup];
}

+ (LUOrderAheadMenuItemOptionGroup *)fixtureForAppetizerSizeOptionGroup {
  return [[LUOrderAheadMenuItemOptionGroup alloc]
    initWithDefaultOptionIDs:@[@1]
                displayOrder:1
            freeChoicesCount:@0
         maximumChoicesCount:@1
         minimumChoicesCount:@1
                        name:@"Appetizer Size"
               optionGroupID:@1
                     options:[LUOrderAheadMenuItemOption fixturesForAppetizerSizeOptions]];
}

+ (LUOrderAheadMenuItemOptionGroup *)fixtureForFillingOptionGroup {
  return [[LUOrderAheadMenuItemOptionGroup alloc]
    initWithDefaultOptionIDs:@[]
                displayOrder:1
            freeChoicesCount:@0
         maximumChoicesCount:nil
         minimumChoicesCount:@0
                        name:@"Filling"
               optionGroupID:@2
                     options:[LUOrderAheadMenuItemOption fixturesForFillingOptions]];
}

+ (LUOrderAheadMenuItemOptionGroup *)fixtureForNachoComboOptionGroup {
  return [[LUOrderAheadMenuItemOptionGroup alloc]
    initWithDefaultOptionIDs:@[@20]
                displayOrder:5
            freeChoicesCount:@0
         maximumChoicesCount:nil
         minimumChoicesCount:@1
                        name:@"Nacho Combo"
               optionGroupID:@6
                     options:[LUOrderAheadMenuItemOption fixturesForNachoComboOptions]];
}

+ (LUOrderAheadMenuItemOptionGroup *)fixtureForSalsaOptionGroup {
  return [[LUOrderAheadMenuItemOptionGroup alloc]
    initWithDefaultOptionIDs:@[@17, @18]
                displayOrder:4
            freeChoicesCount:@0
         maximumChoicesCount:@2
         minimumChoicesCount:@2
                        name:@"Salsa"
               optionGroupID:@5
                     options:[LUOrderAheadMenuItemOption fixturesForSalsaOptions]];
}

+ (LUOrderAheadMenuItemOptionGroup *)fixtureForToppingsOptionGroup {
  return [[LUOrderAheadMenuItemOptionGroup alloc]
    initWithDefaultOptionIDs:@[@12]
                displayOrder:2
            freeChoicesCount:@2
         maximumChoicesCount:@3
         minimumChoicesCount:@1
                        name:@"Toppings"
               optionGroupID:@3
                     options:[LUOrderAheadMenuItemOption fixturesForToppingOptions]];
}

+ (LUOrderAheadMenuItemOptionGroup *)fixtureForTortillaOptionGroup {
  return [[LUOrderAheadMenuItemOptionGroup alloc]
    initWithDefaultOptionIDs:@[@15]
                displayOrder:3
            freeChoicesCount:@0
         maximumChoicesCount:@1
         minimumChoicesCount:@0
                        name:@"Tortilla"
               optionGroupID:@4
                     options:[LUOrderAheadMenuItemOption fixturesForTortillaOptions]];
}

@end
