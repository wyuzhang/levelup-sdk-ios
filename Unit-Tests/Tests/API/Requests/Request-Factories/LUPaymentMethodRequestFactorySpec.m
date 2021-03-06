/*
 * Copyright (C) 2015 SCVNGR, Inc. d/b/a LevelUp
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

#import "LUAPIRequest.h"
#import "LUPaymentMethodRequestFactory.h"

SPEC_BEGIN(LUPaymentMethodRequestFactorySpec)

describe(@"LUPaymentMethodRequestFactory", ^{
  // Public Methods

  __block LUAPIRequest *request;

  describe(@"requestForPaymentMethod", ^{
    beforeEach(^{
      request = [LUPaymentMethodRequestFactory requestForPaymentMethod];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'payment_method'", ^{
      [[request.path should] equal:@"payment_method"];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    it(@"returns a request with no parameters", ^{
      [request.parameters shouldBeNil];
    });
  });

  describe(@"requestToDeactivatePaymentMethod", ^{
    beforeEach(^{
      request = [LUPaymentMethodRequestFactory requestToDeactivatePaymentMethod];
    });

    it(@"returns a DELETE request", ^{
      [[request.method should] equal:@"DELETE"];
    });

    it(@"returns a request to the path 'payment_method'", ^{
      [[request.path should] equal:@"payment_method"];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    it(@"returns a request with no parameters", ^{
      [request.parameters shouldBeNil];
    });
  });
});

SPEC_END
