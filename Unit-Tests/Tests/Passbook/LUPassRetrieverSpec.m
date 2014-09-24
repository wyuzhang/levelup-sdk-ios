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

#import <PassKit/PassKit.h>
#import "LUPassRetriever.h"
#import "LUPassRequestFactory.h"

SPEC_BEGIN(LUPassRetrieverSpec)

describe(@"LUPassRetriever", ^{
  __block LUPassRetriever *retriever;

  beforeEach(^{
    [LUAPIClient setupWithAppID:@"1" APIKey:@"api-key"];
  });

  afterEach(^{
    [[LUAPIStubbing sharedInstance] clearStubs];
  });

  // Object Lifecycle Methods

  describe(@"retrieveAppPassWithCompletionHandler:", ^{
    LUPassRetrieverCompletionHandlerBlock completionHandler = ^(PKPass *pass, NSError *error) { };

    beforeEach(^{
      retriever = [LUPassRetriever mock];
      [LUPassRetriever stub:@selector(alloc) andReturn:retriever];
      [retriever stub:@selector(initWithCompletionHandler:merchantID:) andReturn:retriever
        withArguments:completionHandler, nil];
    });

    it(@"retrieves a pass with the completionHandler and no merchant ID", ^{
      [[retriever should] receive:@selector(retrievePass)];

      [LUPassRetriever retrieveAppPassWithCompletionHandler:completionHandler];
    });
  });

  describe(@"retrievePassForMerchantWithID:withCompletionHandler:", ^{
    LUPassRetrieverCompletionHandlerBlock completionHandler = ^(PKPass *pass, NSError *error) { };
    NSNumber *merchantID = @1;

    beforeEach(^{
      retriever = [LUPassRetriever mock];
      [LUPassRetriever stub:@selector(alloc) andReturn:retriever];
      [retriever stub:@selector(initWithCompletionHandler:merchantID:) andReturn:retriever
        withArguments:completionHandler, merchantID];
    });

    it(@"retrieves a pass with the completionHandler and the merchant ID", ^{
      [[retriever should] receive:@selector(retrievePass)];

      [LUPassRetriever retrievePassForMerchantWithID:merchantID withCompletionHandler:completionHandler];
    });
  });

  // Public Methods

  describe(@"retrievePass", ^{
    __block PKPass *completedPass;
    __block NSError *completedError;

    LUPassRetrieverCompletionHandlerBlock completionHandler = ^(PKPass *pass, NSError *error) {
      completedPass = pass;
      completedError = error;
    };
    NSNumber *merchantID = @1;

    beforeEach(^{
      retriever = [[LUPassRetriever alloc] initWithCompletionHandler:completionHandler merchantID:merchantID];
    });

    context(@"when merchantID is set", ^{
      it(@"requests a pass for the merchantID", ^{
        [[[LUAPIClient sharedClient] should] receive:@selector(performRequest:success:failure:)
                                       withArguments:[LUPassRequestFactory requestForPassWithMerchantID:merchantID], any(), any()];

        [retriever retrievePass];
      });
    });

    context(@"when merchantID is not set", ^{
      beforeEach(^{
        [retriever setValue:nil forKey:@"merchantID"];
      });

      it(@"requests an app pass", ^{
        [[[LUAPIClient sharedClient] should] receive:@selector(performRequest:success:failure:)
                                       withArguments:[LUPassRequestFactory requestForAppPass], any(), any()];

        [retriever retrievePass];
      });
    });

    context(@"when the pass request returns 202", ^{
      beforeEach(^{
        [[LUAPIStubbing sharedInstance] addStub:[LUAPIStubFactory stubToGetPendingPassWithMerchantID:merchantID]];
      });

      it(@"tries to retrieve the pass again after a delay", ^{
        [[expectFutureValue(retriever) shouldEventually] receive:@selector(performSelector:withObject:afterDelay:)
                      withArguments:theValue(@selector(retrievePass)), any(), any()];

        [retriever retrievePass];
      });
    });

    context(@"when the pass request returns 200", ^{
      beforeEach(^{
        [[LUAPIStubbing sharedInstance] addStub:[LUAPIStubFactory stubToGetPassWithMerchantID:merchantID]];
        [[LUAPIStubbing sharedInstance] addStub:[LUAPIStubFactory stubToDownloadPass]];
      });

      it(@"downloads the pass data and calls the completionHandler with a PKPass and no error", ^{
        [retriever retrievePass];

        [[expectFutureValue(completedPass) shouldEventually] beNonNil];
        [[expectFutureValue(completedError) shouldEventually] beNil];
      });
    });

    context(@"when the pass request fails", ^{
      beforeEach(^{
        [[LUAPIStubbing sharedInstance] addStub:[LUAPIStubFactory stubToFailToGetPassWithMerchantID:merchantID]];
      });

      it(@"calls the completionHandler with no PKPass and an error", ^{
        [retriever retrievePass];

        [[expectFutureValue(completedPass) shouldEventually] beNil];
        [[expectFutureValue(completedError) shouldEventually] beNonNil];
      });
    });
  });
});

SPEC_END
