/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
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

#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUDeviceIdentifier.h"
#import "LUIBeaconCheckInRequestFactory.h"
#import "NSDictionary+SafetyAdditions.h"

@implementation LUIBeaconCheckInRequestFactory

+ (LUAPIRequest *)requestToCheckInIBeaconWithMajor:(NSString *)major minor:(NSString *)minor {
  if ([LUAPIClient sharedClient].accessToken.length == 0 && ![LUDeviceIdentifier doesAppIncludeAdSupport]) {
    NSAssert(NO, @"Apps making unauthenticated requests must include AdSupport.");
    return nil;
  }

  NSMutableDictionary *beaconParameters = [NSMutableDictionary dictionary];
  [beaconParameters lu_setSafeValue:major forKey:@"major_id"];
  [beaconParameters lu_setSafeValue:minor forKey:@"minor_id"];

  NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
  [parameters lu_setSafeValue:[LUAPIClient sharedClient].apiKey forKey:@"api_key"];
  [parameters lu_setSafeValue:beaconParameters forKey:@"beacon"];
  [parameters lu_setSafeValue:[LUDeviceIdentifier deviceIdentifier] forKey:@"device_identifier"];

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"beacon_checkins"
                                 apiVersion:LUAPIVersion15
                                 parameters:parameters
                               modelFactory:nil];
}

@end
