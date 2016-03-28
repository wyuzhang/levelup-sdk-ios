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

#import "LUMonetaryValue.h"
#import "LUOrderAheadMenuItemOption+Fixtures.h"

@implementation LUOrderAheadMenuItemOption (Fixtures)

+ (instancetype)fixture {
  return [[LUOrderAheadMenuItemOption alloc] initWithDisplayOrder:1
                                                             name:@"Small"
                                                         optionID:@1
                                                            price:[LUMonetaryValue monetaryValueWithUSCents:@99]];
}

+ (instancetype)fixtureForLargeOption {
  return [[LUOrderAheadMenuItemOption alloc] initWithDisplayOrder:2
                                                             name:@"Large"
                                                         optionID:@2
                                                            price:[LUMonetaryValue monetaryValueWithUSCents:@199]];
}

+ (instancetype)fixtureForSmallOption {
  return [[LUOrderAheadMenuItemOption alloc] initWithDisplayOrder:1
                                                             name:@"Small"
                                                         optionID:@1
                                                            price:[LUMonetaryValue monetaryValueWithUSCents:@99]];
}

+ (NSArray *)fixturesForAppetizerSizeOptions {
  return @[[self fixtureForSmallOption], [self fixtureForLargeOption]];
}

+ (NSArray *)fixturesForFillingOptions {
  return @[[[LUOrderAheadMenuItemOption alloc]
      initWithDisplayOrder:1
                      name:@"Carne Asada"
                  optionID:@3
                     price:[LUMonetaryValue monetaryValueWithUSCents:@0]],
    [[LUOrderAheadMenuItemOption alloc]
      initWithDisplayOrder:2
                      name:@"Shredded Pork"
                  optionID:@4
                     price:[LUMonetaryValue monetaryValueWithUSCents:@0]],
    [[LUOrderAheadMenuItemOption alloc]
      initWithDisplayOrder:3
                      name:@"Roasted Butternut Squash"
                  optionID:@5
                     price:[LUMonetaryValue monetaryValueWithUSCents:@0]],
    [[LUOrderAheadMenuItemOption alloc]
      initWithDisplayOrder:4
                      name:@"Barbacoa"
                  optionID:@6
                     price:[LUMonetaryValue monetaryValueWithUSCents:@0]],
    [[LUOrderAheadMenuItemOption alloc]
      initWithDisplayOrder:5
                      name:@"Steak"
                  optionID:@7
                     price:[LUMonetaryValue monetaryValueWithUSCents:@0]],
    [[LUOrderAheadMenuItemOption alloc]
      initWithDisplayOrder:6
                      name:@"Fajita Veggies"
                  optionID:@8
                     price:[LUMonetaryValue monetaryValueWithUSCents:@0]],
    [[LUOrderAheadMenuItemOption alloc]
      initWithDisplayOrder:7
                      name:@"Chicken"
                  optionID:@9
                     price:[LUMonetaryValue monetaryValueWithUSCents:@0]],
    [[LUOrderAheadMenuItemOption alloc]
      initWithDisplayOrder:8
                      name:@"Pinto Beans"
                  optionID:@10
                     price:[LUMonetaryValue monetaryValueWithUSCents:@0]],
    [[LUOrderAheadMenuItemOption alloc]
      initWithDisplayOrder:9
                      name:@"Cilantro-Lime White Rice"
                  optionID:@11
                     price:[LUMonetaryValue monetaryValueWithUSCents:@0]]];
}

+ (NSArray *)fixturesForNachoComboOptions {
  return @[[[LUOrderAheadMenuItemOption alloc]
             initWithDisplayOrder:1
                             name:@"Side of Nachos"
                         optionID:@20
                            price:[LUMonetaryValue monetaryValueWithUSCents:@0]],
           [[LUOrderAheadMenuItemOption alloc]
             initWithDisplayOrder:2
                             name:@"Nacho Cheese"
                         optionID:@21
                            price:[LUMonetaryValue monetaryValueWithUSCents:@0]]];
}

+ (NSArray *)fixturesForSalsaOptions {
  return @[[[LUOrderAheadMenuItemOption alloc]
             initWithDisplayOrder:1
                             name:@"Salsa Verde"
                         optionID:@17
                            price:[LUMonetaryValue monetaryValueWithUSCents:@0]],
           [[LUOrderAheadMenuItemOption alloc]
             initWithDisplayOrder:2
                             name:@"Salsa Rojo"
                         optionID:@18
                            price:[LUMonetaryValue monetaryValueWithUSCents:@0]],
           [[LUOrderAheadMenuItemOption alloc]
             initWithDisplayOrder:3
                             name:@"Salsa Amarillo"
                         optionID:@19
                            price:[LUMonetaryValue monetaryValueWithUSCents:@0]]];
}

+ (NSArray *)fixturesForToppingOptions {
  return @[[[LUOrderAheadMenuItemOption alloc]
             initWithDisplayOrder:1
                             name:@"Cheese"
                         optionID:@12
                            price:[LUMonetaryValue monetaryValueWithUSCents:@199]],
           [[LUOrderAheadMenuItemOption alloc]
             initWithDisplayOrder:2
                             name:@"Guacamole"
                         optionID:@13
                            price:[LUMonetaryValue monetaryValueWithUSCents:@499]],
           [[LUOrderAheadMenuItemOption alloc]
             initWithDisplayOrder:3
                             name:@"Shredded Lettuce"
                         optionID:@14
                            price:[LUMonetaryValue monetaryValueWithUSCents:@399]],
           [[LUOrderAheadMenuItemOption alloc]
             initWithDisplayOrder:4
                             name:@"Crema"
                         optionID:@22
                            price:[LUMonetaryValue monetaryValueWithUSCents:@399]]];
}

+ (NSArray *)fixturesForTortillaOptions {
  return @[[[LUOrderAheadMenuItemOption alloc]
             initWithDisplayOrder:1
                             name:@"Caseras"
                         optionID:@15
                            price:[LUMonetaryValue monetaryValueWithUSCents:@0]],
           [[LUOrderAheadMenuItemOption alloc]
             initWithDisplayOrder:2
                             name:@"Restaurant Style"
                         optionID:@16
                            price:[LUMonetaryValue monetaryValueWithUSCents:@0]]];
}

@end
