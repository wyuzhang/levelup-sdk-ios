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

#import "LUOrderAheadMenuItem+Fixtures.h"

SPEC_BEGIN(LUOrderAheadMenuItemSpec)

describe(@"LUOrderAheadMenuItem", ^{
  __block LUOrderAheadMenuItem *item;

  beforeEach(^{
    item = [LUOrderAheadMenuItem fixtureForTaterTotsItem];
  });

  it(@"is an LUAPIModel", ^{
    [[[LUOrderAheadMenuItem class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  describe(@"priceIncludingOptionsWithIDs:", ^{
    it(@"returns the total price of the item including the provided options, adding $0.00 for options not found on the"
       "item, and options that should be free", ^{
      LUMonetaryValue *price = [item priceIncludingOptionsWithIDs:@[@1, @2, @3, @4, @5]];

      [[price should] equal:[LUMonetaryValue monetaryValueWithUSCents:@597]];
    });
  });

  describe(@"URLOfLargeImage", ^{
    it(@"returns a large image URL with the correct dimensions & scale parameters", ^{
      NSURL *imageURL = item.URLOfLargeImage;
      NSString *expectedURLString =
        [NSString stringWithFormat:
          @"https://levelup-order-ahead-staging.herokuapp.com/v15/menus/3/items/1/image?density=%d&height=300&width=420",
          (int)[UIScreen mainScreen].scale];

      [[imageURL.absoluteString should] equal:expectedURLString];
    });
  });

  describe(@"URLOfMediumImage", ^{
    it(@"returns a medium image URL with the correct dimensions & scale parameters", ^{
      NSURL *imageURL = item.URLOfMediumImage;
      NSString *expectedURLString =
        [NSString stringWithFormat:
          @"https://levelup-order-ahead-staging.herokuapp.com/v15/menus/3/items/1/image?density=%d&height=180&width=320",
          (int)[UIScreen mainScreen].scale];

      [[imageURL.absoluteString should] equal:expectedURLString];
    });
  });

  describe(@"URLOfSmallImage", ^{
    it(@"returns a small image URL with the correct dimensions & scale parameters", ^{
      NSURL *imageURL = item.URLOfSmallImage;
      NSString *expectedURLString =
        [NSString stringWithFormat:
          @"https://levelup-order-ahead-staging.herokuapp.com/v15/menus/3/items/1/image?density=%d&height=92&width=133",
          (int)[UIScreen mainScreen].scale];

      [[imageURL.absoluteString should] equal:expectedURLString];
    });
  });
});

SPEC_END
