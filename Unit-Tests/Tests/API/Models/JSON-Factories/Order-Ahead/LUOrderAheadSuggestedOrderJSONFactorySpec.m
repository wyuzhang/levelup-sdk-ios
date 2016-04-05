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

#import "LUOrderAheadSuggestedOrder+Fixtures.h"
#import "LUOrderAheadSuggestedOrderJSONFactory.h"
#import "NSDate+StringFormats.h"

SPEC_BEGIN(LUOrderAheadSuggestedOrderJSONFactorySpec)

describe(@"LUOrderAheadSuggestedOrderJSONFactory", ^{
  __block LUOrderAheadSuggestedOrderJSONFactory *factory;
  __block LUOrderAheadSuggestedOrder *suggestedOrderFixture;

  beforeEach(^{
    factory = [LUOrderAheadSuggestedOrderJSONFactory factory];
    suggestedOrderFixture = [LUOrderAheadSuggestedOrder fixtureForDeliveryOrder];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUOrderAheadSuggestedOrder", ^{
      NSDictionary *JSON =
        @{@"banner" : @"past",
          @"created_at": @"2015-09-17T15:00:00Z",
          @"conveyance" : @{
            @"delivery_address_id" : @1,
            @"desired_ready_time" : @"2015-09-17T15:00:00Z",
            @"fulfillment_type" : @"delivery"
            },
          @"description": @"Description",
          @"location_id": @1,
          @"menu_url": @"www.example.com/pickup",
          @"merchant_name": @"Test Merchant",
          @"items" : @[@{@"item" : @{
            @"id": @1,
            @"quantity": @1,
            @"special_instructions": @"",
            @"option_ids": @[@1]
            },},
            @{@"item" : @{
              @"id": @1,
              @"quantity": @1,
              @"special_instructions": @"",
              @"option_ids": @[@1]
            }}],
          @"special_instructions": @"Special Instructions",
          @"total_amount": @1000,
          @"uuid": @"1"
          };

      LUOrderAheadSuggestedOrder *suggestedOrder = [factory createFromAttributes:JSON];
      [[theValue(suggestedOrder.banner) should] equal:theValue(suggestedOrderFixture.banner)];
      [[suggestedOrder.conveyance.deliveryAddressID should] equal:suggestedOrderFixture.conveyance.deliveryAddressID];
      [[suggestedOrder.conveyance.desiredReadyTime should] equal:suggestedOrderFixture.conveyance.desiredReadyTime];
      [[theValue(suggestedOrder.conveyance.fulfillmentType) should] equal:theValue(suggestedOrderFixture.conveyance.fulfillmentType)];
      [[suggestedOrder.createdAtDate should] equal:[NSDate lu_dateFromIso8601DateTimeString:@"2015-09-17T15:00:00Z"]];
      [[[suggestedOrder.items[0] valueForKey:@"itemID"] should] equal:[suggestedOrderFixture.items[0] valueForKey:@"itemID"]];
      [[[suggestedOrder.items[0] valueForKey:@"optionIDs"] should] equal:[suggestedOrderFixture.items[0] valueForKey:@"optionIDs"]];
      [[[suggestedOrder.items[0] valueForKey:@"quantity"] should] equal:[suggestedOrderFixture.items[0] valueForKey:@"quantity"]];
      [[[suggestedOrder.items[1] valueForKey:@"itemID"] should] equal:[suggestedOrderFixture.items[1] valueForKey:@"itemID"]];
      [[[suggestedOrder.items[1] valueForKey:@"optionIDs"] should] equal:[suggestedOrderFixture.items[1] valueForKey:@"optionIDs"]];
      [[[suggestedOrder.items[1] valueForKey:@"quantity"] should] equal:[suggestedOrderFixture.items[1] valueForKey:@"quantity"]];
      [[suggestedOrder.locationID should] equal:suggestedOrderFixture.locationID];
      [[suggestedOrder.menuURL should] equal:suggestedOrderFixture.menuURL];
      [[suggestedOrder.merchantName should] equal:suggestedOrderFixture.merchantName];
      [[suggestedOrder.orderDescription should] equal:suggestedOrderFixture.orderDescription];
      [[suggestedOrder.specialInstructions should] equal:suggestedOrderFixture.specialInstructions];
      [[suggestedOrder.totalAmount should] equal:suggestedOrderFixture.totalAmount];
      [[suggestedOrder.UUID should] equal:suggestedOrderFixture.UUID];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'order'", ^{
      [[[factory rootKey] should] equal:@"order"];
    });
  });
});

SPEC_END
