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

#import "LUOrderAheadViewableOrder+Fixtures.h"
#import "LUOrderAheadViewableOrderJSONFactory.h"
#import "NSDate+StringFormats.h"

SPEC_BEGIN(LUOrderAheadViewableOrderJSONFactorySpec)

describe(@"LUOrderAheadViewableOrderJSONFactory", ^{
  __block LUOrderAheadViewableOrderJSONFactory *factory;
  __block LUOrderAheadViewableOrder *viewableOrderFixture;

  beforeEach(^{
    factory = [LUOrderAheadViewableOrderJSONFactory factory];
    viewableOrderFixture = [LUOrderAheadViewableOrder fixture];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUOrderAheadOrderStatus", ^{
      NSDictionary *JSON =
        @{@"discount_amount" : @100,
          @"location_subtitle" : @"Boston, MA 02114",
          @"location_title" : @"123 Main St.",
          @"order_completion_url" :
            @"https://api.staging-levelup.com/v15/order_ahead/orders/1a2b3c4d5e6f7g8h9i/complete",
          @"service_fee_amount" : @150,
          @"soonest_available_at" : @"2015-09-17T15:00:00Z",
          @"spend_amount" : @498,
          @"state" : @"valid",
          @"tax_amount" : @45,
          @"tip_amount" : @0,
          @"total_amount" : @945,
          @"uuid" : @"1a2b3c4d5e6f7g8h9i"
        };

      LUOrderAheadViewableOrder *viewableOrder = [factory createFromAttributes:JSON];
      [[viewableOrder.discount should] equal:viewableOrderFixture.discount];
      [[viewableOrder.completionURL should] equal:viewableOrderFixture.completionURL];
      [[viewableOrder.locationSubtitle should] equal:viewableOrderFixture.locationSubtitle];
      [[viewableOrder.locationTitle should] equal:viewableOrderFixture.locationTitle];
      [[viewableOrder.serviceFee should] equal:viewableOrderFixture.serviceFee];
      [[viewableOrder.soonestAvailableAt should] equal:viewableOrderFixture.soonestAvailableAt];
      [[viewableOrder.spend should] equal:viewableOrderFixture.spend];
      [[theValue(viewableOrder.state) should] equal:theValue(viewableOrderFixture.state)];
      [[viewableOrder.tax should] equal:viewableOrderFixture.tax];
      [[viewableOrder.tip should] equal:viewableOrderFixture.tip];
      [[viewableOrder.total should] equal:viewableOrderFixture.total];
      [[viewableOrder.UUID should] equal:viewableOrderFixture.UUID];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'order'", ^{
      [[[factory rootKey] should] equal:@"order"];
    });
  });
});

SPEC_END
