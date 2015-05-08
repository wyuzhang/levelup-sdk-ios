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

#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "LUCarrierNetworkDetector.h"

SPEC_BEGIN(LUCarrierNetworkDetectorSpec)

describe(@"LUCarrierNetworkDetector", ^{
  __block CTCarrier *subscriberCellularProvider;
  __block LUAPIClient *apiClient;

  beforeEach(^{
    subscriberCellularProvider = [CTCarrier nullMock];
    CTTelephonyNetworkInfo *telephonyNetworkInfo = [CTTelephonyNetworkInfo nullMock];
    [telephonyNetworkInfo stub:@selector(init) andReturn:telephonyNetworkInfo];
    [telephonyNetworkInfo stub:@selector(subscriberCellularProvider) andReturn:subscriberCellularProvider];
    [CTTelephonyNetworkInfo stub:@selector(alloc) andReturn:telephonyNetworkInfo];
    apiClient = [LUAPIClient nullMock];
    [LUAPIClient stub:@selector(sharedClient) andReturn:apiClient];
  });

  describe(@"deviceIsConnectedToCarrierCellularData", ^{
    context(@"when the device is on the carrier network, and is connected to cellular data", ^{
      beforeEach(^{
        [LUCarrierNetworkDetector stub:@selector(deviceIsOnCarrierNetwork) andReturn:theValue(YES)];
        [apiClient stub:@selector(isNetworkReachableOnCellularData) andReturn:theValue(YES)];
      });

      it(@"returns YES", ^{
        [[theValue([LUCarrierNetworkDetector deviceIsConnectedToCarrierCellularData]) should] beYes];
      });
    });

    context(@"otherwise", ^{
      beforeEach(^{
        [LUCarrierNetworkDetector stub:@selector(deviceIsOnCarrierNetwork) andReturn:theValue(YES)];
        [apiClient stub:@selector(isNetworkReachableOnWifi) andReturn:theValue(YES)];
      });

      it(@"returns NO", ^{
        [[theValue([LUCarrierNetworkDetector deviceIsConnectedToCarrierCellularData]) should] beNo];
      });
    });
  });

  describe(@"deviceIsOnCarrierNetwork", ^{
    context(@"when the country code is 310 and the network code is 020", ^{
      beforeEach(^{
        [subscriberCellularProvider stub:@selector(mobileCountryCode) andReturn:@"310"];
        [subscriberCellularProvider stub:@selector(mobileNetworkCode) andReturn:@"020"];
      });

      it(@"returns YES", ^{
        [[theValue([LUCarrierNetworkDetector deviceIsOnCarrierNetwork]) should] beYes];
      });
    });

    context(@"when the country code is 310 and the network code is 120", ^{
      beforeEach(^{
        [subscriberCellularProvider stub:@selector(mobileCountryCode) andReturn:@"310"];
        [subscriberCellularProvider stub:@selector(mobileNetworkCode) andReturn:@"120"];
      });

      it(@"returns YES", ^{
        [[theValue([LUCarrierNetworkDetector deviceIsOnCarrierNetwork]) should] beYes];
      });
    });

    context(@"when the country code is 311 and the network code is 490", ^{
      beforeEach(^{
        [subscriberCellularProvider stub:@selector(mobileCountryCode) andReturn:@"311"];
        [subscriberCellularProvider stub:@selector(mobileNetworkCode) andReturn:@"490"];
      });

      it(@"returns YES", ^{
        [[theValue([LUCarrierNetworkDetector deviceIsOnCarrierNetwork]) should] beYes];
      });
    });

    context(@"when the country code is 312 and the network code is 530", ^{
      beforeEach(^{
        [subscriberCellularProvider stub:@selector(mobileCountryCode) andReturn:@"312"];
        [subscriberCellularProvider stub:@selector(mobileNetworkCode) andReturn:@"530"];
      });

      it(@"returns YES", ^{
        [[theValue([LUCarrierNetworkDetector deviceIsOnCarrierNetwork]) should] beYes];
      });
    });

    context(@"when the country code is 316 and the network code is 010", ^{
      beforeEach(^{
        [subscriberCellularProvider stub:@selector(mobileCountryCode) andReturn:@"316"];
        [subscriberCellularProvider stub:@selector(mobileNetworkCode) andReturn:@"010"];
      });

      it(@"returns NO", ^{
        [[theValue([LUCarrierNetworkDetector deviceIsOnCarrierNetwork]) should] beYes];
      });
    });

    context(@"otherwise for any other combination", ^{
      beforeEach(^{
        [subscriberCellularProvider stub:@selector(mobileCountryCode) andReturn:@"316"];
        [subscriberCellularProvider stub:@selector(mobileNetworkCode) andReturn:@"011"];
      });

      it(@"returns NO", ^{
        [[theValue([LUCarrierNetworkDetector deviceIsOnCarrierNetwork]) should] beNo];
      });
    });
  });
});

SPEC_END
