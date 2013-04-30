#import "LUAPIRequest.h"
#import "LUApnDevice.h"
#import "LUApnDeviceRequestFactory.h"
#import "LUAuthenticatedAPIRequest.h"
#import "LUKeychainAccess.h"
#import "NSData+HexString.h"

NSString * const LUDeviceTokenKey = @"LUDeviceToken";

@implementation LUApnDeviceRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestToRegisterApnDevice:(LUApnDevice *)apnDevice {
  [[LUKeychainAccess standardKeychainAccess] setString:[apnDevice.token hexString] forKey:LUDeviceTokenKey];

  NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

  if (apnDevice.development) {
    parameters[@"development"] = @YES;
  }

  parameters[@"token"] = [apnDevice.token hexString];

  if (apnDevice.lat && apnDevice.lng) {
    parameters[@"lat"] = apnDevice.lat;
    parameters[@"lng"] = apnDevice.lng;
  }

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"POST"
                                                    path:@"apn_devices"
                                              parameters:@{@"apn_device" : parameters}
                                            modelFactory:nil];
}

+ (LUAPIRequest *)requestToUnregisterCurrentApnDevice {
  NSString *deviceToken = [[LUKeychainAccess standardKeychainAccess] stringForKey:LUDeviceTokenKey];
  if (!deviceToken) return nil;

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"apn_devices"
                                 parameters:@{@"apn_device" : @{@"token" : deviceToken}}
                               modelFactory:nil];
}

@end
