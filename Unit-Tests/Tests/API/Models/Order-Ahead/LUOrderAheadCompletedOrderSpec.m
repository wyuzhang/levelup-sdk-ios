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

#import "LUOrderAheadCompletedOrder.h"

SPEC_BEGIN(LUOrderAheadCompletedOrderSpec)

describe(@"LUOrderAheadCompletedOrder", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUOrderAheadCompletedOrder class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Public Methods

  describe(@"coordinate", ^{
    __block LUOrderAheadCompletedOrder *completedOrder;

    beforeEach(^{
      completedOrder = [LUOrderAheadCompletedOrder fixture];
    });

    context(@"when the order has a latitude and a longitude", ^{
      beforeEach(^{
        [completedOrder stub:@selector(latitude) andReturn:@-70];
        [completedOrder stub:@selector(longitude) andReturn:@45];
      });

      it(@"returns a CLLocationCoordinate2D for the associated location", ^{
        CLLocationCoordinate2D result = [completedOrder coordinate];
        [[@(result.latitude) should] equal:completedOrder.latitude];
        [[@(result.longitude) should] equal:completedOrder.longitude];
      });
    });

    context(@"when the order doesn't have both a latitude and a longitude", ^{
      beforeEach(^{
        [completedOrder stub:@selector(latitude) andReturn:@-70];
        [completedOrder stub:@selector(longitude) andReturn:nil];
      });

      it(@"is kCLLocationCoordinate2DInvalid", ^{
        [[theValue([completedOrder coordinate]) should] equal:theValue(kCLLocationCoordinate2DInvalid)];
      });
    });
  });
});

SPEC_END
