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
#import "NSDictionary+SafetyAdditions.h"

@implementation LUCarrierNetworkDetector

+ (BOOL)deviceIsConnectedToCarrierCellularData {
  return [self deviceIsOnCarrierNetwork] && [[LUAPIClient sharedClient] isNetworkReachableOnCellularData];
}

+ (BOOL)deviceIsOnCarrierNetwork {
  CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
  CTCarrier *carrier = [networkInfo subscriberCellularProvider];
  NSString *countryCode = [carrier mobileCountryCode];
  NSString *networkCode = [carrier mobileNetworkCode];

  return [self networkCodePairsIncludeCountryCode:countryCode withNetworkCode:networkCode];
}

#pragma mark - Private Methods

+ (NSDictionary *)networkCodePairs {
  static NSDictionary* networkCodePairs = nil;
  static dispatch_once_t onceToken;

  dispatch_once(&onceToken, ^{
    networkCodePairs = @{@"310" : @[@"020", @"120"],
                         @"311" : @[@"490"],
                         @"312" : @[@"530"],
                         @"316" : @[@"010"]};
  });

  return networkCodePairs;
}

+ (BOOL)networkCodePairsIncludeCountryCode:(NSString *)countryCode withNetworkCode:(NSString *)networkCode {
  NSArray *expectedNetworkCodes = [[self networkCodePairs] lu_safeValueForKey:countryCode];

  for (NSString *expectedNetworkCode in expectedNetworkCodes) {
    if ([expectedNetworkCode isEqualToString:networkCode]) {
      return YES;
    }
  }

  return NO;
}

@end
