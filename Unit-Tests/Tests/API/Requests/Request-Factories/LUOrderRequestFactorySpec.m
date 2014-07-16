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

#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUOrderRequestFactory.h"

SPEC_BEGIN(LUOrderRequestFactorySpec)

describe(@"LUOrderRequestFactory", ^{
  // Public Methods

  __block LUAPIRequest *request;

  describe(@"requestForOrders", ^{
    beforeEach(^{
      request = [LUOrderRequestFactory requestForOrders];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'apps/orders'", ^{
      [[request.path should] equal:@"apps/orders"];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });
  });

  describe(@"requestForOrdersOnPage:", ^{
    NSURL *pageURL = [NSURL URLWithString:@"http://example.com/next_page?key=value"];

    beforeEach(^{
      request = [LUOrderRequestFactory requestForOrdersOnPage:pageURL];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path provided by the page URL", ^{
      [[request.path should] equal:@"next_page?key=value"];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });
  });

  describe(@"requestForOrderWithUUID:", ^{
    NSString *UUID = @"dc3ef230f251013007583c075468379e";

    beforeEach(^{
      request = [LUOrderRequestFactory requestForOrderWithUUID:UUID];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    it(@"returns a request to the path 'orders/<uuid>'", ^{
      NSString *expectedPath = [NSString stringWithFormat:@"orders/%@", UUID];

      [[request.path should] equal:expectedPath];
    });
  });
});

SPEC_END
