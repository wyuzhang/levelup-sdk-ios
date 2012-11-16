#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUApnDevice.h"
#import "LUApnDeviceRequest.h"

@implementation LUApnDeviceRequest

+ (LUAPIRequest *)createApnDevice:(LUApnDevice *)apnDevice {
  return [LUAPIRequest authenticatedApiRequestWithMethod:@"POST" path:@"apn_devices" parameters:@{@"apn_device" : apnDevice.parameters}];
}

@end
