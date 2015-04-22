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
#import "LUMonetaryValue.h"
#import "LUPaymentOptionsSummaryJSONFactory.h"
#import "LUPaymentPreference.h"
#import "LUPaymentPreferenceRequestFactory.h"
#import "NSDictionary+SafetyAdditions.h"

@implementation LUPaymentPreferenceRequestFactory

+ (LUAPIRequest *)requestForPaymentOptionsSummary {
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:@"payment_options_summary"
                                 apiVersion:LUAPIVersion15
                                 parameters:nil
                               modelFactory:[LUPaymentOptionsSummaryJSONFactory factory]];
}

+ (LUAPIRequest *)requestToSetPaymentPreference:(LUPaymentPreference *)paymentPreference {
  NSMutableDictionary *paymentPreferenceParameters = [NSMutableDictionary dictionary];
  paymentPreferenceParameters[@"preload"] = @(paymentPreference.preload);

  if (paymentPreference.preload) {
    [paymentPreferenceParameters lu_setSafeValue:paymentPreference.preloadValue.amount forKey:@"preload_value_amount"];
  }

  return [LUAPIRequest apiRequestWithMethod:@"PUT"
                                       path:@"apps/payment_preference"
                                 apiVersion:LUAPIVersion15
                                 parameters:@{@"payment_preference": paymentPreferenceParameters}
                               modelFactory:nil];
}

@end
