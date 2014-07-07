// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUAPNDeviceRequestFactory.h"
#import "LUKeychainAccess.h"
#import "NSData+LUAdditions.h"

NSString * const LUDeviceTokenKey = @"LUDeviceToken";

@implementation LUAPNDeviceRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestToRegisterAPNDeviceWithToken:(NSData *)deviceToken sandbox:(BOOL)sandbox {
  [[LUKeychainAccess standardKeychainAccess] setString:[deviceToken lu_hexString] forKey:LUDeviceTokenKey];

  NSDictionary *parameters = @{
    @"apn_device": @{
      @"sandbox": @(sandbox),
      @"token": [deviceToken lu_hexString]
    }
  };

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"apn_devices"
                                 apiVersion:LUAPIVersion15
                                 parameters:parameters
                               modelFactory:nil];
}

+ (LUAPIRequest *)requestToUnregisterCurrentAPNDevice {
  NSString *deviceToken = [[LUKeychainAccess standardKeychainAccess] stringForKey:LUDeviceTokenKey];
  if (!deviceToken) return nil;

  NSString *path = [NSString stringWithFormat:@"apn_devices/%@", deviceToken];

  return [LUAPIRequest apiRequestWithMethod:@"DELETE"
                                       path:path
                                 apiVersion:LUAPIVersion15
                                 parameters:@{@"api_key": [LUAPIClient sharedClient].apiKey}
                               modelFactory:nil];
}

@end
