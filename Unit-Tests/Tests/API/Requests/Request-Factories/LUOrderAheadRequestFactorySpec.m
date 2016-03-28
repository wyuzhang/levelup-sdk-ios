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

#import "LULocationJSONFactory.h"
#import "LUOrderAheadCompletedOrderJSONFactory.h"
#import "LUOrderAheadMenuJSONFactory.h"
#import "LUOrderAheadOrder+Fixtures.h"
#import "LUOrderAheadOrderStatusJSONFactory.h"
#import "LUOrderAheadRequestFactory.h"
#import "LUOrderAheadSuggestedOrder.h"
#import "LUOrderAheadSuggestedOrderJSONFactory.h"
#import "LUOrderAheadViewableOrder+Fixtures.h"
#import "LUOrderAheadViewableOrderJSONFactory.h"

SPEC_BEGIN(LUOrderAheadRequestFactorySpec)

describe(@"LUOrderAheadRequestFactory", ^{
  __block LUAPIRequest *request;
  NSURL *orderURL =
    [NSURL URLWithString:@"https://api.staging-levelup.com/v15/order_ahead/orders/1a2b3c4d5e6f7g8h9i9h8g7f6e5d4c3b2a1"];

  describe(@"requestForCompletedOrderWithURL:", ^{
    beforeEach(^{
      request = [LUOrderAheadRequestFactory requestForCompletedOrderWithURL:orderURL];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the completed order URL", ^{
      [[request.URLRequest.URL.absoluteString should] equal:orderURL.absoluteString];
    });

    it(@"returns a request set up to pass the response to an instance of LUOrderAheadCompletedOrderJSONFactory", ^{
      [[request.modelFactory should] beKindOfClass:[LUOrderAheadCompletedOrderJSONFactory class]];
    });

    it(@"returns a request that should be retried every half second after receiving a 202 response code", ^{
      [[request.retryResponseCodes should] equal:@[@202]];
      [[theValue(request.retryTimeInterval) should] equal:theValue(0.5)];
    });
  });

  describe(@"requestForDeliveryLocationForUserAddressWithID:", ^{
    beforeEach(^{
      request = [LUOrderAheadRequestFactory requestForDeliveryLocationForUserAddressWithID:@1];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request with the path user_addresses/1/delivery_location", ^{
      [[request.path should] equal:@"user_addresses/1/delivery_location"];
    });

    it(@"returns a request set up to pass the response to an instance of LULocationJSONFactory", ^{
      [[request.modelFactory should] beKindOfClass:[LULocationJSONFactory class]];
    });
  });

  describe(@"requestForMenuWithID:", ^{
    NSURL *menuURL = [NSURL URLWithString:@"https://api.thelevelup.com/v15/menus/1"];

    beforeEach(^{
      request = [LUOrderAheadRequestFactory requestForMenuWithURL:menuURL];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the menu URL", ^{
      [[request.URLRequest.URL.absoluteString should] equal:menuURL.absoluteString];
    });

    it(@"returns a request set up to pass the response to an instance of LUOrderAheadMenuJSONFactory", ^{
      [[request.modelFactory should] beKindOfClass:[LUOrderAheadMenuJSONFactory class]];
    });
  });

  describe(@"requestForPastOrdersForLocationWithID:", ^{
    NSNumber *locationID = @1;

    beforeEach(^{
      request = [LUOrderAheadRequestFactory requestForPastOrdersForLocationWithID:locationID];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request with parameters for the locationID and types", ^{
      [[request.parameters should] equal:@{@"location_id":@1, @"types":@"past"}];
    });

    it(@"returns a request set up to pass the response to an instance of LUOrderAheadSuggestedOrderJSONFactory", ^{
      [[request.modelFactory should] beKindOfClass:[LUOrderAheadSuggestedOrderJSONFactory class]];
    });
  });

  describe(@"requestForSuggestedOrdersForLocationWithID:types:", ^{
    NSNumber *locationID = @1;
    NSArray *types = @[[LUOrderAheadSuggestedOrder stringForOrderType:LUOrderAheadSuggestedOrderTypePast]];

    beforeEach(^{
      request = [LUOrderAheadRequestFactory requestForSuggestedOrdersForLocationWithID:locationID types:types];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request with parameters for the locationID and types", ^{
      [[request.parameters should] equal:@{@"location_id":@1, @"types":@"past"}];
    });

    it(@"returns a request set up to pass the response to an instance of LUOrderAheadSuggestedOrderJSONFactory", ^{
      [[request.modelFactory should] beKindOfClass:[LUOrderAheadSuggestedOrderJSONFactory class]];
    });
  });

  describe(@"requestForViewableOrderWithURL:", ^{
    beforeEach(^{
      request = [LUOrderAheadRequestFactory requestForViewableOrderWithURL:orderURL];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the order URL", ^{
      [[request.URLRequest.URL.absoluteString should] equal:orderURL.absoluteString];
    });

    it(@"returns a request set up to pass the response to an instance of LUOrderAheadViewableOrderJSONFactory", ^{
      [[request.modelFactory should] beKindOfClass:[LUOrderAheadViewableOrderJSONFactory class]];
    });

    it(@"returns a request that should be retried every half second after receiving a 202 response code", ^{
      [[request.retryResponseCodes should] equal:@[@202]];
      [[theValue(request.retryTimeInterval) should] equal:theValue(0.5)];
    });
  });

  describe(@"requestToCompleteOrderWithURL:", ^{
    NSURL *completionURL = [LUOrderAheadViewableOrder fixture].completionURL;

    beforeEach(^{
      request = [LUOrderAheadRequestFactory requestToCompleteOrderWithURL:completionURL];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the completion URL", ^{
      [[request.URLRequest.URL should] equal:completionURL];
    });

    it(@"returns a request set up to pass the response to an instance of LUOrderAheadOrderStatusJSONFactory", ^{
      [[request.modelFactory should] beKindOfClass:[LUOrderAheadOrderStatusJSONFactory class]];
    });
  });

  describe(@"requestToStartUpdateOfOrder:", ^{
    LUOrderAheadOrder *order = [LUOrderAheadOrder fixture];

    beforeEach(^{
      request = [LUOrderAheadRequestFactory requestToStartUpdateOfOrder:order];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request with the path order_ahead/orders", ^{
      [[request.path should] equal:@"order_ahead/orders"];
    });

    it(@"returns a request set up to pass the response to an instance of LUOrderAheadOrderStatusJSONFactory", ^{
      [[request.modelFactory should] beKindOfClass:[LUOrderAheadOrderStatusJSONFactory class]];
    });
  });
});

SPEC_END
