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

#import "LUInterstitialRequestFactory.h"

SPEC_BEGIN(LUInterstitialRequestFactorySpec)

describe(@"LUInterstitialRequestFactory", ^{
  NSString *UUID = @"uuid";

  // Public Methods

  __block LUAPIRequest *request;

  describe(@"requestForInterstitialForOrderWithUUID:", ^{
    beforeEach(^{
      request = [LUInterstitialRequestFactory requestForInterstitialForOrderWithUUID:UUID];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'orders/<uuid>/interstitial'", ^{
      NSString *expectedPath = [NSString stringWithFormat:@"orders/%@/interstitial", UUID];

      [[request.path should] equal:expectedPath];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });
  });

  describe(@"requestToSubmitFeedbackForOrderWithUUID:questionText:rating:comment:", ^{
    NSString *questionText = @"Question?";
    int rating = 5;
    NSString *comment = @"No comment";

    beforeEach(^{
      request = [LUInterstitialRequestFactory requestToSubmitFeedbackForOrderWithUUID:UUID
                                                                         questionText:questionText
                                                                               rating:rating
                                                                              comment:comment];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'orders/<uuid>/feedback'", ^{
      NSString *expectedPath = [NSString stringWithFormat:@"orders/%@/feedback", UUID];

      [[request.path should] equal:expectedPath];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    it(@"returns a request with feedback parameters for the credit card", ^{
      NSDictionary *expectedParams = @{
        @"feedback" : @{
          @"comment": comment,
          @"rating": [@(rating) stringValue],
          @"question_text" : questionText
        }
      };

      [[request.parameters should] equal:expectedParams];
    });
  });
});

SPEC_END
