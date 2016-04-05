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

#import "LUOrderAheadCompletedOrder+Fixtures.h"
#import "LUOrderAheadCompletedOrderJSONFactory.h"
#import "LUOrderAheadOrderConveyance.h"

SPEC_BEGIN(LUOrderAheadCompletedOrderJSONFactorySpec)

describe(@"LUOrderAheadCompletedOrderJSONFactory", ^{
  __block LUOrderAheadCompletedOrderJSONFactory *factory;

  beforeEach(^{
    factory = [LUOrderAheadCompletedOrderJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUOrderAheadCompletedOrder", ^{
      NSDictionary *JSON = @{
        @"conveyance" : @{
          @"delivery_address_id" : [NSNull null],
          @"desired_ready_time" : @"2015-09-17T15:00:00Z",
          @"fulfillment_type" : @"pickup"
        },
        @"discount_amount" : @100,
        @"instructions" : @"Pick up your food on the left side of the counter under the sign.",
        @"items" : @[
          @{
            @"item" : @{
              @"name" : @"Tater Tots",
              @"quantity" : @1,
              @"selected_options_description" : @"Small"
            }
          }
        ],
        @"latitude" : @70,
        @"location_subtitle" : @"Boston, MA 02114",
        @"location_title" : @"123 Main St.",
        @"longitude" : @-45,
        @"order_number" : @"1000432",
        @"phone" : @"6175551234",
        @"ready_at" : @"2015-09-17T15:08:00Z",
        @"total_amount" : @945
      };

      LUOrderAheadCompletedOrder *order = [factory createFromAttributes:JSON];
      LUOrderAheadCompletedOrder *fixture = [LUOrderAheadCompletedOrder fixture];

      [[order.conveyance should] equal:fixture.conveyance];
      [[order.discount should] equal:fixture.discount];
      [[order.instructions should] equal:fixture.instructions];
      [[order.items should] equal:fixture.items];
      [[order.latitude should] equal:fixture.latitude];
      [[order.locationSubtitle should] equal:fixture.locationSubtitle];
      [[order.locationTitle should] equal:fixture.locationTitle];
      [[order.longitude should] equal:fixture.longitude];
      [[order.orderNumber should] equal:fixture.orderNumber];
      [[order.phone should] equal:fixture.phone];
      [[order.readyAt should] equal:fixture.readyAt];
      [[order.total should] equal:fixture.total];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'order'", ^{
      [[[factory rootKey] should] equal:@"order"];
    });
  });
});

SPEC_END
