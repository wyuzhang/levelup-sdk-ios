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

#import "LUOrderAheadOrderStatus+Fixtures.h"
#import "LUOrderAheadOrderStatusJSONFactory.h"

SPEC_BEGIN(LUOrderAheadOrderStatusJSONFactorySpec)

describe(@"LUOrderAheadOrderStatusJSONFactory", ^{
  __block LUOrderAheadOrderStatusJSONFactory *factory;
  __block LUOrderAheadOrderStatus *orderStatusFixture;

  beforeEach(^{
    factory = [LUOrderAheadOrderStatusJSONFactory factory];
    orderStatusFixture = [LUOrderAheadOrderStatus fixture];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUOrderAheadOrderStatus", ^{
      NSDictionary *JSON =
        @{@"order_url": @"https://api.staging-levelup.com/v15/order_ahead/orders/1a2b3c4d5e6f7g8h9i",
          @"state": @"validating",
          @"uuid": @"1a2b3c4d5e6f7g8h9i"
        };

      LUOrderAheadOrderStatus *orderStatus = [factory createFromAttributes:JSON];
      [[orderStatus.orderURL should] equal:orderStatusFixture.orderURL];
      [[theValue(orderStatus.state) should] equal:theValue(orderStatusFixture.state)];
      [[orderStatus.UUID should] equal:orderStatusFixture.UUID];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'order'", ^{
      [[[factory rootKey] should] equal:@"order"];
    });
  });
});

SPEC_END
