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

#import "LUAPIClient.h"
#import "LUAPIStubbing.h"
#import "LUAPIStubFactory.h"
#import "LUCarrierAccount+Fixtures.h"
#import "LUCarrierAccountRequestFactory.h"
#import "LUCarrierAccountRetriever.h"
#import "LUCarrierNetworkDetector.h"
#import "NSError+LUAdditions.h"

SPEC_BEGIN(LUCarrierAccountRetrieverSpec)

describe(@"LUCarrierAccountRetriever", ^{
  __block LUCarrierAccount *carrierAccountFixture = [LUCarrierAccount fixture];

  beforeEach(^{
    [LUAPIClient setupWithAppID:@"1" APIKey:@"api-key"];
    [[LUAPIClient sharedClient] setAccessToken:@"access-token"];
  });

  afterEach(^{
    [[LUAPIStubbing sharedInstance] clearStubs];
  });

  describe(@"retrieveMDNSuppliedCarrierAccountWithCompletionHandler:", ^{
    __block LUCarrierAccount *completedCarrierAccount;
    __block NSError *completedError;

    LUCarrierAccountRetrieverCompletionHandlerBlock completionHandler = ^(LUCarrierAccount *carrierAccount, NSError *error) {
      completedCarrierAccount = carrierAccount;
      completedError = error;
    };

    context(@"when the device is connected to the carrier network cellular data", ^{
      beforeEach(^{
        [LUCarrierNetworkDetector stub:@selector(deviceIsConnectedToCarrierCellularData) andReturn:theValue(YES)];
      });

      it(@"requests carrier account identification", ^{
        [[[LUAPIClient sharedClient] should] receive:@selector(performRequest:success:failure:)
                                       withArguments:[LUCarrierAccountRequestFactory requestForCarrierAccountIdentification], any(), any()];
        [LUCarrierAccountRetriever retrieveMDNSuppliedCarrierAccountWithCompletionHandler:completionHandler];
      });

      context(@"when the EVURL updated carrier account request returns 200", ^{
        beforeEach(^{
          [[LUAPIStubbing sharedInstance] addStub:[LUAPIStubFactory stubToIdentifyCarrierAccount]];
          [[LUAPIStubbing sharedInstance] addStub:
           [LUAPIStubFactory stubToGetUpdatedCarrierAccountWithID:carrierAccountFixture.carrierAccountID]];
        });

        context(@"when the EVURL request returns a success status", ^{
          beforeEach(^{
            [[LUAPIStubbing sharedInstance] addStub:[LUAPIStubFactory stubToGetCarrierAccountEVURL]];
          });

          it(@"calls the completion handler with the updated carrier account and no error", ^{
            [LUCarrierAccountRetriever retrieveMDNSuppliedCarrierAccountWithCompletionHandler:completionHandler];

            [[completedCarrierAccount shouldEventually] beNonNil];
            [[completedCarrierAccount.mobileDeviceNumber shouldEventually]
             equal:carrierAccountFixture.mobileDeviceNumber];
            [[completedCarrierAccount.carrierName shouldEventually]
             equal:carrierAccountFixture.carrierName];
            [[completedError shouldEventually] beNil];
          });
        });

        context(@"when the EVURL request returns a failure status", ^{
          beforeEach(^{
            [[LUAPIStubbing sharedInstance] addStub:[LUAPIStubFactory stubToFailToGetCarrierAccountEVURL]];
          });

          it(@"calls the completion handler with an error and no carrier account", ^{
            [LUCarrierAccountRetriever retrieveMDNSuppliedCarrierAccountWithCompletionHandler:completionHandler];

            [[completedCarrierAccount shouldEventually] beNil];
            [[theValue(completedError) shouldEventually] beNonNil];
          });
        });
      });
    });

    context(@"when the device is not connnected to the carrier network cellular data", ^{
      beforeEach(^{
        [LUCarrierNetworkDetector stub:@selector(deviceIsConnectedToCarrierCellularData) andReturn:theValue(NO)];
      });

      it(@"calls the completion handler with an error and no carrier account", ^{
        [LUCarrierAccountRetriever retrieveMDNSuppliedCarrierAccountWithCompletionHandler:completionHandler];

        [[completedCarrierAccount shouldEventually] beNil];
        [[theValue(completedError) shouldEventually] beNonNil];
      });
    });

    describe(@"updateCarrierAccount:withCompletionHandler:", ^{
      __block LUCarrierAccount *completedCarrierAccount;
      __block NSError *completedError;

      LUCarrierAccountRetrieverCompletionHandlerBlock completionHandler = ^(LUCarrierAccount *carrierAccount, NSError *error) {
        completedCarrierAccount = carrierAccount;
        completedError = error;
      };

      it(@"makes a request to update the carrier account", ^{
        [[[LUAPIClient sharedClient] should]
         receive:@selector(performRequest:success:failure:)
         withArguments:[LUCarrierAccountRequestFactory requestToUpdateCarrierAccountWithID:carrierAccountFixture.carrierAccountID
                                                                        mobileDeviceNumber:carrierAccountFixture.mobileDeviceNumber
                                                                               carrierName:carrierAccountFixture.carrierName], any(), any()];
        [LUCarrierAccountRetriever updateCarrierAccount:carrierAccountFixture withCompletionHandler:completionHandler];
      });

      context(@"when the update request succeeds and and the polling get updated account request succeeds", ^{
        beforeEach(^{
          [[LUAPIStubbing sharedInstance] addStub:
           [LUAPIStubFactory stubToUpdateCarrierAccountWithID:carrierAccountFixture.carrierAccountID
                                           mobileDeviceNumber:carrierAccountFixture.mobileDeviceNumber
                                                  carrierName:carrierAccountFixture.carrierName]];
          [[LUAPIStubbing sharedInstance] addStub:
           [LUAPIStubFactory stubToGetUpdatedCarrierAccountWithID:carrierAccountFixture.carrierAccountID]];
        });

        it(@"calls the completion handler with the updated carrier account, and no error", ^{
          [LUCarrierAccountRetriever updateCarrierAccount:carrierAccountFixture withCompletionHandler:completionHandler];

          [[completedCarrierAccount shouldEventually] equal:carrierAccountFixture];
          [[completedError shouldEventually] beNil];
        });
      });
    });
  });
});

SPEC_END
