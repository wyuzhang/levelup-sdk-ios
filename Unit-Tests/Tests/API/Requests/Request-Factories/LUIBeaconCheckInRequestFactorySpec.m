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
#import "LUDeviceIdentifier.h"
#import "LUIBeaconCheckInRequestFactory.h"

SPEC_BEGIN(LUIBeaconCheckInRequestFactorySpec)

describe(@"LUIBeaconCheckInRequestFactory", ^{
  // Public Methods

  describe(@"requestToCheckInIBeaconWithMajor:minor:", ^{
    NSString *apiKey = @"api-key";
    NSString *deviceIdentifier = @"device-identifier";
    NSString *major = @"1";
    NSString *minor = @"2";

    beforeEach(^{
      [LUAPIClient setupWithAppID:@"1" APIKey:apiKey];
      [LUDeviceIdentifier stub:@selector(deviceIdentifier) andReturn:deviceIdentifier];
    });

    context(@"when an access token has been set", ^{
      __block LUAPIRequest *request;

      beforeEach(^{
        [LUAPIClient sharedClient].accessToken = @"access-token";
        request = [LUIBeaconCheckInRequestFactory requestToCheckInIBeaconWithMajor:major minor:minor];
      });

      it(@"returns a POST request", ^{
        [[request.method should] equal:@"POST"];
      });

      it(@"returns a request to the path 'beacon_checkins", ^{
        NSString *expectedPath = @"beacon_checkins";

        [[request.path should] equal:expectedPath];
      });

      it(@"returns a request to version 15 of the API", ^{
        [[request.apiVersion should] equal:LUAPIVersion15];
      });

      it(@"returns a request with the API key in the paramters", ^{
        [[request.parameters[@"api_key"] should] equal:apiKey];
      });

      it(@"returns a request with the device identifier in the paramters", ^{
        [[request.parameters[@"device_identifier"] should] equal:deviceIdentifier];
      });

      it(@"returns a request with paramters including the major and minor ids", ^{
        NSDictionary *expectedBeaconParameters = @{@"major_id": major, @"minor_id": minor};

        [[request.parameters[@"beacon"] should] equal:expectedBeaconParameters];
      });
    });

    context(@"when an access token hasn't been set", ^{
      beforeEach(^{
        [LUAPIClient sharedClient].accessToken = nil;
      });

      context(@"and the app doesn't include AdSupport", ^{
        beforeEach(^{
          [LUDeviceIdentifier stub:@selector(doesAppIncludeAdSupport) andReturn:theValue(NO)];
        });

        it(@"throws an exception", ^{
          [[theBlock(^{
            [LUIBeaconCheckInRequestFactory requestToCheckInIBeaconWithMajor:major minor:minor];
          }) should] raise];
        });
      });

      context(@"and the app includes AdSupport", ^{
        beforeEach(^{
          [LUDeviceIdentifier stub:@selector(doesAppIncludeAdSupport) andReturn:theValue(YES)];
        });

        it(@"doesn't throw an exception", ^{
          [[theBlock(^{
            [LUIBeaconCheckInRequestFactory requestToCheckInIBeaconWithMajor:major minor:minor];
          }) shouldNot] raise];
        });
      });
    });
  });
});

SPEC_END
