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

#import "LUCarrierAccount.h"
#import "LUCarrierAccountJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCarrierAccountJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSNumber *carrierAccountID = [attributes lu_numberForKey:@"id"];
  NSString *carrierName = [attributes lu_stringForKey:@"carrier"];
  NSNumber *creditCardID = [attributes lu_numberForKey:@"credit_card_id"];
  NSURL *evURL = [attributes lu_URLForKey:@"ev_url"];
  LUCarrierAccountState carrierAccountState =
    [LUCarrierAccount carrierAccountStateForStateString:[attributes lu_stringForKey:@"state"]];
  NSString *mobileDeviceNumber = [attributes lu_stringForKey:@"mobile_device_number"];

  return [[LUCarrierAccount alloc] initWithCarrierAccountID:carrierAccountID
                                                carrierName:carrierName
                                               creditCardID:creditCardID
                                                      EVURL:evURL
                                         mobileDeviceNumber:mobileDeviceNumber
                                                      state:carrierAccountState];
}

- (NSString *)rootKey {
  return @"carrier_account";
}

@end
