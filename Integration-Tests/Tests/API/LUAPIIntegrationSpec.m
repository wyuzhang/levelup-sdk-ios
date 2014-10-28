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

SPEC_BEGIN(LUAPIIntegrationSpec)

describe(@"API", ^{
  beforeEach(^{
    [LUAPIClient setupWithAppID:@"1" APIKey:@"api-key"];
    [LUAPIClient sharedClient].accessToken = @"access-token";

    [[LUAPIStubbing sharedInstance] disableNetConnect];
  });

  afterEach(^{
    [[LUAPIStubbing sharedInstance] clearStubs];
  });

  context(@"a successful API call", ^{
    beforeEach(^{
      [[LUAPIStubbing sharedInstance] addStub:[LUAPIStubFactory stubToGetPaymentToken]];
    });

    it(@"calls the success block with the parsed response object", ^{
      __block id responseObject;

      [[LUAPIClient sharedClient] performRequest:[LUPaymentTokenRequestFactory requestForPaymentToken]
                                         success:^(id result, LUAPIResponse *response) {
                                           responseObject = result;
                                         }
                                         failure:nil];

      [[expectFutureValue(responseObject) shouldEventually] beNonNil];
      [[expectFutureValue(responseObject) shouldEventually] beKindOfClass:[LUPaymentToken class]];
      [[expectFutureValue([(LUPaymentToken *)responseObject data]) shouldEventually] equal:@"LU02000TESTTESTTEST01234"];
    });
  });

  context(@"a failing API call", ^{
    beforeEach(^{
      [[LUAPIStubbing sharedInstance] addStub:[LUAPIStubFactory stubToGetIneligiblePaymentToken]];
    });

    it(@"calls the failure block with a relevant error", ^{
      __block NSError *error;

      [[LUAPIClient sharedClient] performRequest:[LUPaymentTokenRequestFactory requestForPaymentToken]
                                         success:nil
                                         failure:^(NSError *errorResponse) {
                                           error = errorResponse;
                                         }];

      [[expectFutureValue(error) shouldEventually] beNonNil];
      [[expectFutureValue(error.domain) shouldEventually] equal:LUAPIErrorDomain];
      [[expectFutureValue(theValue(error.code)) shouldEventually] equal:theValue(LUAPIErrorNotFound)];
    });
  });
});

SPEC_END
