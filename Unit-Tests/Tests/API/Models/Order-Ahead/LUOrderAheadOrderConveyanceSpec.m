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

#import "LUOrderAheadOrderConveyance.h"

SPEC_BEGIN(LUOrderAheadOrderConveyanceSpec)

describe(@"LUOrderAheadOrderConveyance", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUOrderAheadOrderConveyance class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  describe(@"fulfillmentTypeFromString:", ^{
    it(@"converts the string to an LUOrderConveyanceFulfillmentType", ^{
      [[theValue([LUOrderAheadOrderConveyance fulfillmentTypeFromString:@"unknown"]) should]
       equal:theValue(LUOrderConveyanceFulfillmentTypeUnknown)];
      [[theValue([LUOrderAheadOrderConveyance fulfillmentTypeFromString:@"pickup"]) should]
       equal:theValue(LUOrderConveyanceFulfillmentTypePickup)];
      [[theValue([LUOrderAheadOrderConveyance fulfillmentTypeFromString:@"delivery"]) should]
       equal:theValue(LUOrderConveyanceFulfillmentTypeDelivery)];
    });
  });

  describe(@"stringForFulfillmentType:", ^{
    it(@"converts the LUOrderConveyanceFulfillmentType to a string", ^{
      [[[LUOrderAheadOrderConveyance stringForFulfillmentType:LUOrderConveyanceFulfillmentTypeUnknown] should]
       equal:@"unknown"];
      [[[LUOrderAheadOrderConveyance stringForFulfillmentType:LUOrderConveyanceFulfillmentTypePickup] should]
       equal:@"pickup"];
      [[[LUOrderAheadOrderConveyance stringForFulfillmentType:LUOrderConveyanceFulfillmentTypeDelivery] should]
       equal:@"delivery"];
    });
  });
});

SPEC_END
