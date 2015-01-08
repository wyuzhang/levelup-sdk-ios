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

#import "LUAPIRequest.h"
#import "LUCarrierAccountJSONFactory.h"
#import "LUCarrierAccountRequestFactory.h"
#import "NSDictionary+SafetyAdditions.h"

@implementation LUCarrierAccountRequestFactory

+ (LUAPIRequest *)requestForCarrierAccountIdentification {
  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"carrier_accounts"
                                 apiVersion:LUAPIVersion15
                                 parameters:nil
                               modelFactory:[LUCarrierAccountJSONFactory factory]];
}


+ (LUAPIRequest *)requestForUpdatedCarrierAccountWithID:(NSNumber *)carrierAccountID {
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:[self carrierAccountPathForID:carrierAccountID]
                                 apiVersion:LUAPIVersion15
                                 parameters:nil
                               modelFactory:[LUCarrierAccountJSONFactory factory]
                         retryResponseCodes:@[@202] retryTimeInterval:0.5];
}

+ (LUAPIRequest *)requestToUpdateCarrierAccountWithID:(NSNumber *)carrierAccountID
                                   mobileDeviceNumber:(NSString *)mobileDeviceNumber
                                          carrierName:(NSString *)carrierName {
  NSMutableDictionary *updatedCarrierProperties = [NSMutableDictionary dictionary];
  [updatedCarrierProperties lu_setSafeValue:carrierName forKey:@"carrier"];
  [updatedCarrierProperties lu_setSafeValue:mobileDeviceNumber forKey:@"mobile_device_number"];

  NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
  [parameters lu_setSafeValue:updatedCarrierProperties forKey:@"carrier_account"];

  return [LUAPIRequest apiRequestWithMethod:@"PUT"
                                       path:[self carrierAccountPathForID:carrierAccountID]
                                 apiVersion:LUAPIVersion15
                                 parameters:parameters
                               modelFactory:[LUCarrierAccountJSONFactory factory]];
}

#pragma mark - Private Methods

+ (NSString *)carrierAccountPathForID:(NSNumber *)carrierAccountID {
  return [NSString stringWithFormat:@"carrier_accounts/%@", [carrierAccountID stringValue]];
}

@end
