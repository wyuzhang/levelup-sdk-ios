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
#import "LUPaymentPreferenceRequestFactory.h"

SPEC_BEGIN(LUPaymentPreferenceRequestFactorySpec)

describe(@"LUPaymentPreferenceRequestFactory", ^{
  // Public Methods

  __block LUAPIRequest *request;

  describe(@"requestForPaymentOptionsSummary", ^{
    beforeEach(^{
      request = [LUPaymentPreferenceRequestFactory requestForPaymentOptionsSummary];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'payment_options_summary'", ^{
      [[request.path should] equal:@"payment_options_summary"];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    it(@"returns a request with no parameters", ^{
      [request.parameters shouldBeNil];
    });
  });

  describe(@"requestToSetPaymentPreference:", ^{
    beforeEach(^{
      LUPaymentPreference *paymentPreference = [[LUPaymentPreference alloc] initWithPreload:NO preloadValue:nil];
      request = [LUPaymentPreferenceRequestFactory requestToSetPaymentPreference:paymentPreference];
    });

    it(@"returns a PUT request", ^{
      [[request.method should] equal:@"PUT"];
    });

    it(@"returns a request to the path 'apps/payment_preference'", ^{
      [[request.path should] equal:@"apps/payment_preference"];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    context(@"when preloading is set to NO", ^{
      it(@"returns a request with the expected payment preferences", ^{
        NSDictionary *expectedParams = @{
          @"payment_preference": @{
            @"preload": @NO
          }
        };

        [[request.parameters should] equal:expectedParams];
      });
    });

    context(@"when preloading is set to YES", ^{
      beforeEach(^{
        LUPaymentPreference *paymentPreference = [[LUPaymentPreference alloc] initWithPreload:YES
                                                                                 preloadValue:[LUMonetaryValue monetaryValueWithUSD:@25]];
        request = [LUPaymentPreferenceRequestFactory requestToSetPaymentPreference:paymentPreference];
      });

      it(@"returns a request with the expected payment preferences", ^{
        NSDictionary *expectedParams = @{
          @"payment_preference": @{
            @"preload": @YES,
            @"preload_value_amount": @2500
          }
        };

        [[request.parameters should] equal:expectedParams];
      });
    });
  });
});

SPEC_END
