#import "LUAPIRequest.h"
#import "LUApnDevice.h"
#import "LUApnDeviceRequestBuilder.h"
#import "LUKeychainAccess.h"

SPEC_BEGIN(LUApnDeviceRequestBuilderSpec)

describe(@"LUApnDeviceRequestBuilder", ^{
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

      request = [LUApnDeviceRequestBuilder requestToRegisterApnDevice:apnDevice];
    });

    it(@"stores the token string in the keychain", ^{
      [[[[LUKeychainAccess standardKeychainAccess] should] receive] setString:@"A60F7DB9" forKey:DeviceTokenKey];

      [LUApnDeviceRequestBuilder requestToRegisterApnDevice:apnDevice];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'apn_devices'", ^{
      [[request.path should] equal:@"apn_devices"];
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
        request = [LUApnDeviceRequestBuilder requestToRegisterApnDevice:apnDevice];

        [[request.parameters[@"apn_device"][@"lat"] should] equal:apnDevice.lat];
        [[request.parameters[@"apn_device"][@"lng"] should] equal:apnDevice.lng];
      });
    });
  });

  describe(@"requestToUnregisterCurrentApnDevice", ^{
    context(@"when a device has been previously registered", ^{
      __block LUAPIRequest *request;

      beforeEach(^{
        [[[[LUKeychainAccess standardKeychainAccess] should] receiveAndReturn:@"ABCDEF"] stringForKey:DeviceTokenKey];

        request = [LUApnDeviceRequestBuilder requestToUnregisterCurrentApnDevice];
      });

      it(@"returns a request without the access token", ^{
        [[theValue(request.includeAccessToken) should] beNo];
      });

      it(@"returns a POST request", ^{
        [[request.method should] equal:@"POST"];
      });

      it(@"returns a request to the path 'apn_devices'", ^{
        [[request.path should] equal:@"apn_devices"];
      });

      it(@"returns the previously registered device token in the parameters", ^{
        NSDictionary *expectedParams = @{@"apn_device" : @{ @"token" : @"ABCDEF" } };

        [[request.parameters should] equal:expectedParams];
      });
    });

    context(@"when a device hasn't been previously registered", ^{
      it(@"is nil", ^{
        [[LUApnDeviceRequestBuilder requestToUnregisterCurrentApnDevice] shouldBeNil];
      });
    });
  });
});

SPEC_END
