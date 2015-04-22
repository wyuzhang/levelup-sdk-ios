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

#import "LUPaymentOptionsSummary.h"
#import "LUPaymentOptionsSummaryJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUPaymentOptionsSummaryJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  LUMonetaryValue *maxCreditLimit = [attributes lu_monetaryValueForKey:@"max_credit_limit_amount"];
  NSNumber *monthlyBillingDay = [attributes lu_numberForKey:@"monthly_billing_day"];
  NSArray *options = [attributes lu_arrayForKey:@"options"];
  LUMonetaryValue *preloadReloadThreshold = [attributes lu_monetaryValueForKey:@"preload_reload_threshold_amount"];
  LUMonetaryValue *preloadValue = [attributes lu_monetaryValueForKey:@"preload_value_amount"];

  return [[LUPaymentOptionsSummary alloc] initWithMaxCreditLimit:maxCreditLimit
                                               monthlyBillingDay:monthlyBillingDay
                                                         options:options
                                          preloadReloadThreshold:preloadReloadThreshold
                                                    preloadValue:preloadValue];
}

- (NSString *)rootKey {
  return @"payment_options_summary";
}

@end
