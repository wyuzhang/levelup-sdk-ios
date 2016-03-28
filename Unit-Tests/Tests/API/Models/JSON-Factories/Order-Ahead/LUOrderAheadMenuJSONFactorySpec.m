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
#import "LUOrderAheadMenuItem.h"
#import "LUOrderAheadMenuJSONFactory.h"
#import "LUOrderAheadMenuItemOptionGroup.h"
#import "LUOrderAheadMenuItemOption.h"

SPEC_BEGIN(LUOrderAheadMenuJSONFactorySpec)

describe(@"LUOrderAheadMenuJSONFactory", ^{
  __block LUOrderAheadMenuJSONFactory *factory;
  __block LUOrderAheadMenu *menuFixture;

  beforeEach(^{
    factory = [LUOrderAheadMenuJSONFactory factory];
    menuFixture = [LUOrderAheadMenu fixture];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUOrderAheadMenu", ^{
      NSDictionary *JSON = @{
        @"id" : @1,
        @"categories" : @[
          @{@"category" :
            @{@"id" : @1,
              @"description" : @"Small dishes to share while you wait for the main course.",
              @"display_order" : @1,
              @"items" : @[
                @{@"item" :
                  @{@"id" : @1,
                    @"display_order" : @1,
                    @"image_url" :
                    @"https://levelup-order-ahead-staging.herokuapp.com/v15/menus/3/items/1/image",
                    @"description" : @"Try our tots!",
                    @"name" : @"Tater Tots",
                    @"nutrition" : @{@"calories" : @"390"},
                    @"option_groups" : @[
                      @{@"option_group" :
                        @{@"id" : @1,
                          @"default_option_ids" : @[@1],
                          @"display_order" : @1,
                          @"free_choices" : @0,
                          @"maximum_choices" : @1,
                          @"minimum_choices" : @1,
                          @"name" : @"Appetizer Size",
                          @"options" : @[
                            @{@"option" :
                              @{@"id" : @1,
                                @"display_order" : @1,
                                @"name" : @"Small",
                                @"price_amount" : @99}},
                            @{@"option" :
                              @{@"id" : @2,
                                @"display_order" : @2,
                                @"name" : @"Large",
                                @"price_amount" : @199}}]}}],
                    @"price_amount" : @299,
                    @"price_with_defaults_amount" : @398,
                    @"sku" : @"5586F636",
                    @"upc" : [NSNull null]}}],
              @"name" : @"Appetizers"}},
          @{@"category" :
            @{@"id" : @2,
              @"description" : [NSNull null],
              @"display_order" : @2,
              @"items" : @[
                @{@"item" :
                  @{@"id" : @2,
                    @"display_order" : @1,
                    @"image_url" : [NSNull null],
                    @"description" : @"A food torpedo.",
                    @"name" : @"Burrito",
                    @"nutrition" : @{@"calories" : @"640"},
                    @"option_groups" : @[
                      @{@"option_group" :
                        @{@"id" : @2,
                          @"default_option_ids" : @[],
                          @"display_order" : @1,
                          @"free_choices" : @0,
                          @"maximum_choices" : [NSNull null],
                          @"minimum_choices" : @0,
                          @"name" : @"Filling",
                          @"options" : @[
                            @{@"option" :
                              @{@"id" : @3,
                                @"display_order" : @1,
                                @"name" : @"Carne Asada",
                                @"price_amount" : @0}},
                            @{@"option" :
                              @{@"id" : @4,
                                @"display_order" : @2,
                                @"name" : @"Shredded Pork",
                                @"price_amount" : @0}},
                            @{@"option" :
                              @{@"id" : @5,
                                @"display_order" : @3,
                                @"name" : @"Roasted Butternut Squash",
                                @"price_amount" : @0}},
                            @{@"option" :
                              @{@"id" : @6,
                                @"display_order" : @4,
                                @"name" : @"Barbacoa",
                                @"price_amount" : @0}},
                            @{@"option" :
                              @{@"id" : @7,
                                @"display_order" : @5,
                                @"name" : @"Steak",
                                @"price_amount" : @0}},
                            @{@"option" :
                              @{@"id" : @8,
                                @"display_order" : @6,
                                @"name" : @"Fajita Veggies",
                                @"price_amount" : @0}},
                            @{@"option" :
                              @{@"id" : @9,
                                @"display_order" : @7,
                                @"name" : @"Chicken",
                                @"price_amount" : @0}},
                            @{@"option" :
                              @{@"id" : @10,
                                @"display_order" : @8,
                                @"name" : @"Pinto Beans",
                                @"price_amount" : @0}},
                            @{@"option" :
                              @{@"id" : @11,
                                @"display_order" : @9,
                                @"name" : @"Cilantro-Lime White Rice",
                                @"price_amount" : @0}}]}},
                      @{@"option_group" :
                        @{@"id" : @3,
                          @"default_option_ids" : @[@12],
                          @"display_order" : @2,
                          @"free_choices" : @1,
                          @"maximum_choices" : @2,
                          @"minimum_choices" : @1,
                          @"name" : @"Toppings",
                          @"options" : @[
                            @{@"option" :
                              @{@"id" : @12,
                                @"display_order" : @1,
                                @"name" : @"Cheese",
                                @"price_amount" : @0}},
                            @{@"option" :
                              @{@"id" : @13,
                                @"display_order" : @2,
                                @"name" : @"Guacamole",
                                @"price_amount" : @0}},
                            @{@"option" :
                              @{@"id" : @14,
                                @"display_order" : @3,
                                @"name" : @"Shredded Lettuce",
                                @"price_amount" : @0}}]}},
                      @{@"option_group" :
                        @{@"id" : @4,
                          @"default_option_ids" : @[@15],
                          @"display_order" : @3,
                          @"free_choices" : @0,
                          @"maximum_choices" : @1,
                          @"minimum_choices" : @0,
                          @"name" : @"Tortilla",
                          @"options" : @[
                            @{@"option" :
                              @{@"id" : @15,
                                @"display_order" : @1,
                                @"name" : @"Caseras",
                                @"price_amount" : @0}},
                            @{@"option" :
                              @{@"id" : @16,
                                @"display_order" : @2,
                                @"name" : @"Restaurant Style",
                                @"price_amount" : @0}}]}},
                      @{@"option_group" :
                        @{@"id" : @5,
                          @"default_option_ids" : @[@17, @18],
                          @"display_order" : @4,
                          @"free_choices" : @0,
                          @"maximum_choices" : @2,
                          @"minimum_choices" : @2,
                          @"name" : @"Salsa",
                          @"options" : @[
                            @{@"option" :
                              @{@"id" : @17,
                                @"display_order" : @1,
                                @"name" : @"Salsa Verde",
                                @"price_amount" : @0}},
                            @{@"option" :
                              @{@"id" : @18,
                                @"display_order" : @2,
                                @"name" : @"Salsa Rojo",
                                @"price_amount" : @0}},
                            @{@"option" :
                              @{@"id" : @19,
                                @"display_order" : @3,
                                @"name" : @"Salsa Amarillo",
                                @"price_amount" : @0}}]}},
                      @{@"option_group" :
                        @{@"id" : @6,
                          @"default_option_ids" : @[@20],
                          @"display_order" : @5,
                          @"free_choices" : @0,
                          @"maximum_choices" : [NSNull null],
                          @"minimum_choices" : @1,
                          @"name" : @"Nacho Combo",
                          @"options" : @[
                            @{@"option" :
                              @{@"id" : @20,
                                @"display_order" : @1,
                                @"name" : @"Side of Nachos",
                                @"price_amount" : @0}},
                            @{@"option" :
                              @{@"id" : @21,
                                @"display_order" : @2,
                                @"name" : @"Nacho Cheese",
                                @"price_amount" : @0}}]}}],
                    @"price_amount" : @699,
                    @"price_with_defaults_amount" : @699,
                    @"sku" : @"2EC6DC79",
                    @"upc" : [NSNull null]}}],
              @"name" : @"Lunch"}},
          @{@"category" :
            @{@"id" : @3,
              @"description" : [NSNull null],
              @"name" : @"Drinks",
              @"display_order" : @3,
              @"items" : @[
                @{@"item" :
                  @{@"id" : @3,
                    @"display_order" : @1,
                    @"image_url" : [NSNull null],
                    @"description" : @"Not available in California.",
                    @"name" : @"Water",
                    @"nutrition" : @{@"calories" : @"0"},
                    @"option_groups" : @[],
                    @"price_amount" : @349,
                    @"price_with_defaults_amount" : @349,
                    @"sku" : @"EE703FCC",
                    @"upc" : [NSNull null]}},
                @{@"item" :
                  @{@"id" : @4,
                    @"display_order" : @2,
                    @"image_url" : @"https://levelup-order-ahead-staging.herokuapp.com/v15/menus/3/items/4/image",
                    @"description" : @"Widely available in California!",
                    @"name" : @"Beer",
                    @"nutrition" : @{@"calories" : @"140"},
                    @"option_groups" : @[],
                    @"price_amount" : @615,
                    @"price_with_defaults_amount" : @615,
                    @"sku" : @"3AC7098F",
                    @"upc" : [NSNull null]}}]}}]};

      LUOrderAheadMenu *menu = [factory createFromAttributes:JSON];
      LUOrderAheadMenuCategory *category = menu.categories[0];
      LUOrderAheadMenuItem *item = category.items[0];
      LUOrderAheadMenuItemOptionGroup *optionGroup = item.optionGroups[0];
      LUOrderAheadMenuItemOption *option = optionGroup.options[0];

      [[menu.menuID should] equal:menuFixture.menuID];
      [[category.name should] equal:@"Appetizers"];
      [[item.name should] equal:@"Tater Tots"];
      [[optionGroup.name should] equal:@"Appetizer Size"];
      [[option.name should] equal:@"Small"];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'menu'", ^{
      [[[factory rootKey] should] equal:@"menu"];
    });
  });
});

SPEC_END
