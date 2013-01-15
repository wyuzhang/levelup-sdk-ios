#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUApnDevice.h"
#import "LUApnDeviceRequest.h"
#import "LUParameterSerializer.h"

@implementation LUApnDeviceRequest

+ (LUAPIRequest *)createApnDevice:(LUApnDevice *)apnDevice {
  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"apn_devices"
                                 parameters:@{@"apn_device" : [LUParameterSerializer nonBlankParametersForModel:apnDevice attributes:@[@"development", @"lat", @"lng", @"token"]]}];
}

+ (LUAPIRequest *)unregisterApnDevice:(LUApnDevice *)apnDevice {
  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"apn_devices"
                                 parameters:@{@"apn_device" : [LUParameterSerializer nonBlankParametersForModel:apnDevice attributes:@[@"development", @"lat", @"lng", @"token"]]}
                         skipAuthentication:YES];
}

@end
