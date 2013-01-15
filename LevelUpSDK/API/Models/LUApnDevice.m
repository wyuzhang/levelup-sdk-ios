#import "LUAPIClient.h"
#import "LUApnDevice.h"
#import "LUApnDeviceRequest.h"
#import "LUKeychainAccess.h"
#import "LUParameterSerializer.h"

static NSString * const DeviceIdentifierKey = @"LUDeviceToken";

@implementation LUApnDevice

#pragma mark - Public Methods

+ (void)registerDeviceToken:(NSData *)deviceToken sandbox:(BOOL)sandbox {
  NSString *deviceTokenString = [[[[deviceToken description]
                                   stringByReplacingOccurrencesOfString:@"<" withString:@""]
                                  stringByReplacingOccurrencesOfString:@">" withString:@""]
                                 stringByReplacingOccurrencesOfString:@" " withString:@""];

  [[LUKeychainAccess standardKeychainAccess] setString:deviceTokenString forKey:DeviceIdentifierKey];

  LUApnDevice *device = [[self alloc] init];
  device.token = deviceTokenString;

  if (sandbox) {
    device.development = @YES;
  }

  [[LUAPIClient sharedClient] performRequest:[LUApnDeviceRequest createApnDevice:device] success:nil failure:nil];
}

+ (void)unregisterDeviceToken {
  NSString *deviceToken = [[LUKeychainAccess standardKeychainAccess] stringForKey:DeviceIdentifierKey];

  if (deviceToken.length > 0) {
    LUApnDevice *device = [[self alloc] init];
    device.token = deviceToken;

    [[LUAPIClient sharedClient] performRequest:[LUApnDeviceRequest unregisterApnDevice:device] success:nil failure:nil];
  }
}

@end
