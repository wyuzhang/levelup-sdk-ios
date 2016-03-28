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
#import "LUOrderAheadOrder+Fixtures.h"

SPEC_BEGIN(LUOrderAheadOrderSpec)

describe(@"LUOrderAheadOrder", ^{
  __block LUOrderAheadOrder *order;

  beforeEach(^{
    order = [LUOrderAheadOrder fixture];
  });

  it(@"is an LUAPIModel", ^{
    [[[LUOrderAheadOrder class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  describe(@"JSONDictionary", ^{
    it(@"returns a JSON representation of the order", ^{
      NSDictionary *JSON = @{
        @"order" : @{
          @"conveyance" : @{
            @"fulfillment_type" : @"pickup",
            @"desired_ready_time" : [NSNull null],
            @"delivery_address_id" : [NSNull null]},
          @"items" : @[@{@"item" : @{@"id" : @1,
                                     @"quantity" : @1,
                                     @"special_instructions" : [NSNull null],
                                     @"option_ids" : @[@1]}}],
          @"location_id" : @1,
          @"special_instructions" : [NSNull null],
          @"tip_amount" : [NSNull null]}};

      [[[order JSONDictionary] should] equal:JSON];
    });
  });
});

SPEC_END
