#import "LUAPIRequest.h"
#import "LUApnDevice.h"
#import "LUApnDeviceRequestBuilder.h"
#import "LUKeychainAccess.h"
#import "NSData+HexString.h"

NSString * const DeviceTokenKey = @"LUDeviceToken";

@implementation LUApnDeviceRequestBuilder

#pragma mark - Public Methods

+ (LUAPIRequest *)requestToRegisterApnDevice:(LUApnDevice *)apnDevice {
  [[LUKeychainAccess standardKeychainAccess] setString:[apnDevice.token hexString] forKey:DeviceTokenKey];

  NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

  if (apnDevice.development) {
    parameters[@"development"] = @YES;
  }

  parameters[@"token"] = [apnDevice.token hexString];

  if (apnDevice.lat && apnDevice.lng) {
    parameters[@"lat"] = apnDevice.lat;
    parameters[@"lng"] = apnDevice.lng;
  }

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"apn_devices"
                                 parameters:@{@"apn_device" : parameters}];
}

+ (LUAPIRequest *)requestToUnregisterCurrentApnDevice {
  NSString *deviceToken = [[LUKeychainAccess standardKeychainAccess] stringForKey:DeviceTokenKey];
  if (!deviceToken) return nil;

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"apn_devices"
                                 parameters:@{@"apn_device" : @{@"token" : deviceToken}}
                         includeAccessToken:NO];
}

@end
