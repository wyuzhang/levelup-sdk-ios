// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIRequest.h"
#import "LUAPNDeviceRequestFactory.h"
#import "LUKeychainAccess.h"

SPEC_BEGIN(LUAPNDeviceRequestFactorySpec)

describe(@"LUAPNDeviceRequestFactory", ^{
  // Public Methods

  beforeEach(^{
    [LUKeychainAccess stub:@selector(standardKeychainAccess) andReturn:[LUKeychainAccess nullMock]];
  });

  describe(@"requestToRegisterApnDevice:", ^{
    const unsigned char bytes[4] = { 0xA6, 0x0F, 0x7D, 0xB9 };
    NSData *deviceToken = [NSData dataWithBytes:bytes length:4];
    BOOL sandbox = YES;

    __block LUAPIRequest *request;

    beforeEach(^{
      request = [LUAPNDeviceRequestFactory requestToRegisterAPNDeviceWithToken:deviceToken sandbox:sandbox];
    });

    it(@"stores the token string in the keychain", ^{
      [[[LUKeychainAccess standardKeychainAccess] should] receive:@selector(setString:forKey:) withArguments:@"A60F7DB9", LUDeviceTokenKey];

      [LUAPNDeviceRequestFactory requestToRegisterAPNDeviceWithToken:deviceToken sandbox:sandbox];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'apn_devices'", ^{
      [[request.path should] equal:@"apn_devices"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request with the expected parameters", ^{
      NSDictionary *expectedParams = @{@"apn_device" : @{ @"sandbox" : @YES, @"token" : @"A60F7DB9" } };

      [[request.parameters should] equal:expectedParams];
    });
  });

  describe(@"requestToUnregisterCurrentAPNDevice", ^{
    context(@"when a device has been previously registered", ^{
      __block LUAPIRequest *request;

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

      it(@"returns a request to version 14 of the API", ^{
        [[request.apiVersion should] equal:LUAPIVersion14];
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
