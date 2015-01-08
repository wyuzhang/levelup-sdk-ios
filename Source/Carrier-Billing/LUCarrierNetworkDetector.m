/*
 * Copyright (C) 2015 SCVNGR, Inc. d/b/a LevelUp
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

#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "LUAPIClient.h"
#import "LUCarrierNetworkDetector.h"

NSString *const LUSprintNextelCountryCode = @"311";
NSString *const LUSprintNextelNetworkCode = @"490";
NSString *const LUSprintSpectrumCountryCode = @"310";
NSString *const LUSprintSpectrumNetworkCode = @"120";

@implementation LUCarrierNetworkDetector

+ (BOOL)deviceIsConnectedToCarrierCellularData {
  return [self deviceIsOnCarrierNetwork] && [[LUAPIClient sharedClient] isNetworkReachableOnCellularData];
}

+ (BOOL)deviceIsOnCarrierNetwork {
  CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
  CTCarrier *carrier = [networkInfo subscriberCellularProvider];
  NSString *countryCode = [carrier mobileCountryCode];
  NSString *networkCode = [carrier mobileNetworkCode];

  BOOL deviceIsOnSprintNextelNetwork =
    [countryCode isEqualToString:LUSprintSpectrumCountryCode] && [networkCode isEqualToString:LUSprintSpectrumNetworkCode];
  BOOL deviceIsOnSprintSpectrumNetwork =
    [countryCode isEqualToString:LUSprintNextelCountryCode] && [networkCode isEqualToString:LUSprintNextelNetworkCode];

  return deviceIsOnSprintNextelNetwork || deviceIsOnSprintSpectrumNetwork;
}

@end
