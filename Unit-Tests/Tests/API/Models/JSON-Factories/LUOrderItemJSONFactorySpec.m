/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
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

#import "LUOrderItemJSONFactory.h"

SPEC_BEGIN(LUOrderItemJSONFactorySpec)

describe(@"LUOrderItemJSONFactory", ^{
  __block LUOrderItemJSONFactory *factory;

  beforeEach(^{
    factory = [LUOrderItemJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUOrder", ^{
      NSDictionary *JSON = @{
        @"category": @"Fruit",
        @"charged_price_amount": @500,
        @"description": @"An apple",
        @"name": @"Apple",
        @"quantity": @1,
        @"sku": @"ABC123",
        @"standard_price_amount": @1000,
        @"upc": @"123456789999"
      };
      LUOrderItem *item = [factory createFromAttributes:JSON];

      [[item.category should] equal:@"Fruit"];
      [[item.chargedPrice should] equal:[LUMonetaryValue monetaryValueWithUSCents:@500]];
      [[item.itemDescription should] equal:@"An apple"];
      [[item.name should] equal:@"Apple"];
      [[theValue(item.quantity) should] equal:theValue(1)];
      [[item.SKU should] equal:@"ABC123"];
      [[item.standardPrice should] equal:[LUMonetaryValue monetaryValueWithUSCents:@1000]];
      [[item.UPC should] equal:@"123456789999"];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'item'", ^{
      [[[factory rootKey] should] equal:@"item"];
    });
  });
});

SPEC_END
