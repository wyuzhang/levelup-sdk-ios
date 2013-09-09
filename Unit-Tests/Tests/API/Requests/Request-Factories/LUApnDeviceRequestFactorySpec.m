// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIRequest.h"
#import "LUApnDevice.h"
#import "LUApnDeviceRequestFactory.h"
#import "LUAuthenticatedAPIRequest.h"
#import "LUKeychainAccess.h"

SPEC_BEGIN(LUApnDeviceRequestFactorySpec)

describe(@"LUApnDeviceRequestFactory", ^{
  // Public Methods

  beforeEach(^{
    [LUKeychainAccess stub:@selector(standardKeychainAccess) andReturn:[LUKeychainAccess nullMock]];
  });

  describe(@"requestToRegisterApnDevice:", ^{
    __block LUApnDevice *apnDevice;
    __block LUAPIRequest *request;

    beforeEach(^{
      apnDevice = [[LUApnDevice alloc] init];

      const unsigned char bytes[4] = { 0xA6, 0x0F, 0x7D, 0xB9 };
      apnDevice.token = [NSData dataWithBytes:bytes length:4];
      apnDevice.development = YES;

      request = [LUApnDeviceRequestFactory requestToRegisterApnDevice:apnDevice];
    });

    it(@"stores the token string in the keychain", ^{
      [[[[LUKeychainAccess standardKeychainAccess] should] receive] setString:@"A60F7DB9" forKey:LUDeviceTokenKey];

      [LUApnDeviceRequestFactory requestToRegisterApnDevice:apnDevice];
    });

    it(@"returns an authenticated request", ^{
      [[request should] beKindOfClass:[LUAuthenticatedAPIRequest class]];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'apn_devices'", ^{
      [[request.path should] equal:@"apn_devices"];
    });

    it(@"returns a request to version 13 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion13];
    });

    it(@"returns a request with the expected parameters", ^{
      NSDictionary *expectedParams = @{@"apn_device" : @{ @"development" : @YES, @"token" : @"A60F7DB9" } };

      [[request.parameters should] equal:expectedParams];
    });

    context(@"when the device includes a lat and lng", ^{
      beforeEach(^{
        apnDevice.lat = @-70;
        apnDevice.lng = @45;
      });

      it(@"includes the lat and lng in the parameters", ^{
        request = [LUApnDeviceRequestFactory requestToRegisterApnDevice:apnDevice];

        [[request.parameters[@"apn_device"][@"lat"] should] equal:apnDevice.lat];
        [[request.parameters[@"apn_device"][@"lng"] should] equal:apnDevice.lng];
      });
    });
  });

  describe(@"requestToUnregisterCurrentApnDevice", ^{
    context(@"when a device has been previously registered", ^{
      __block LUAPIRequest *request;

      beforeEach(^{
        [[[[LUKeychainAccess standardKeychainAccess] should] receiveAndReturn:@"ABCDEF"] stringForKey:LUDeviceTokenKey];

        request = [LUApnDeviceRequestFactory requestToUnregisterCurrentApnDevice];
      });

      it(@"returns a POST request", ^{
        [[request.method should] equal:@"POST"];
      });

      it(@"returns a request to the path 'apn_devices'", ^{
        [[request.path should] equal:@"apn_devices"];
      });

      it(@"returns a request to version 13 of the API", ^{
        [[request.apiVersion should] equal:LUAPIVersion13];
      });

      it(@"returns the previously registered device token in the parameters", ^{
        NSDictionary *expectedParams = @{@"apn_device" : @{ @"token" : @"ABCDEF" } };

        [[request.parameters should] equal:expectedParams];
      });
    });

    context(@"when a device hasn't been previously registered", ^{
      it(@"is nil", ^{
        [[LUApnDeviceRequestFactory requestToUnregisterCurrentApnDevice] shouldBeNil];
      });
    });
  });
});

SPEC_END
