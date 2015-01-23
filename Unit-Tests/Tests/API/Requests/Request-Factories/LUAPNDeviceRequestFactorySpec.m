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

#import "LUAPIRequest.h"
#import "LUAPNDeviceRequestFactory.h"
#import "LUDeviceIdentifier.h"
#import "LUKeychainAccess.h"

SPEC_BEGIN(LUAPNDeviceRequestFactorySpec)

describe(@"LUAPNDeviceRequestFactory", ^{
  NSString *apiKey = @"api-key";
  __block LUAPIRequest *request;

  beforeEach(^{
    [LUAPIClient setupWithAppID:@"1" APIKey:apiKey];
    [LUKeychainAccess stub:@selector(standardKeychainAccess) andReturn:[LUKeychainAccess nullMock]];
  });

  // Public Methods

  describe(@"requestToRegisterApnDevice:", ^{
    const unsigned char bytes[4] = { 0xA6, 0x0F, 0x7D, 0xB9 };
    NSString *deviceIdentifier = @"device-identifier";
    NSData *deviceToken = [NSData dataWithBytes:bytes length:4];
    BOOL sandbox = YES;

    beforeEach(^{
      [LUDeviceIdentifier stub:@selector(deviceIdentifier) andReturn:deviceIdentifier];
      request = [LUAPNDeviceRequestFactory requestToRegisterAPNDeviceWithToken:deviceToken sandbox:sandbox];
    });

    it(@"stores the token string in the keychain", ^{
      [[[LUKeychainAccess standardKeychainAccess] should] receive:@selector(setString:forKey:)
                                                    withArguments:@"A60F7DB9", LUDeviceTokenKey, nil];

      [LUAPNDeviceRequestFactory requestToRegisterAPNDeviceWithToken:deviceToken sandbox:sandbox];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'apn_devices'", ^{
      [[request.path should] equal:@"apn_devices"];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    it(@"returns a request with the expected parameters", ^{
      NSDictionary *expectedParams = @{
        @"api_key": apiKey,
        @"apn_device": @{
          @"device_identifier": deviceIdentifier,
          @"sandbox": @YES,
          @"token": @"A60F7DB9"
        }
      };

      [[request.parameters should] equal:expectedParams];
    });
  });

  describe(@"requestToUnregisterCurrentAPNDevice", ^{
    context(@"when a device has been previously registered", ^{
      beforeEach(^{
        [[[[LUKeychainAccess standardKeychainAccess] should] receiveAndReturn:@"ABCDEF"] stringForKey:LUDeviceTokenKey];

        request = [LUAPNDeviceRequestFactory requestToUnregisterCurrentAPNDevice];
      });

      it(@"returns a DELETE request", ^{
        [[request.method should] equal:@"DELETE"];
      });

      it(@"returns a request to the path 'apn_devices/:token'", ^{
        [[request.path should] equal:@"apn_devices/ABCDEF"];
      });

      it(@"returns a request to version 15 of the API", ^{
        [[request.apiVersion should] equal:LUAPIVersion15];
      });

      it(@"returns a request which includes the API key as a parameter", ^{
        [request.parameters shouldNotBeNil];
        [[request.parameters[@"api_key"] should] equal:apiKey];
      });
    });

    context(@"when a device hasn't been previously registered", ^{
      it(@"is nil", ^{
        [[LUAPNDeviceRequestFactory requestToUnregisterCurrentAPNDevice] shouldBeNil];
      });
    });
  });
});

SPEC_END
