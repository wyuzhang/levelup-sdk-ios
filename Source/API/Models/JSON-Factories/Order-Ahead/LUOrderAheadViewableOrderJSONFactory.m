/*
 * Copyright (C) 2016 SCVNGR, Inc. d/b/a LevelUp
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

#import "LUOrderAheadViewableOrder.h"
#import "LUOrderAheadViewableOrderJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUOrderAheadViewableOrderJSONFactory

#pragma mark - LUAbstractJSONModelFactory Methods

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSURL *completionURL = [attributes lu_URLForKey:@"order_completion_url"];
  LUMonetaryValue *discount = [attributes lu_monetaryValueForKey:@"discount_amount"];
  NSString *locationSubtitle = [attributes lu_stringForKey:@"location_subtitle"];
  NSString *locationTitle = [attributes lu_stringForKey:@"location_title"];
  LUMonetaryValue *serviceFee = [attributes lu_monetaryValueForKey:@"service_fee_amount"];
  NSDate *soonestAvailableAt = [attributes lu_dateForKey:@"soonest_available_at"];
  LUMonetaryValue *spend = [attributes lu_monetaryValueForKey:@"spend_amount"];
  LUOrderAheadOrderState state = [LUOrderAheadOrderStateParser stateForString:[attributes lu_stringForKey:@"state"]];
  LUMonetaryValue *tax = [attributes lu_monetaryValueForKey:@"tax_amount"];
  LUMonetaryValue *tip = [attributes lu_monetaryValueForKey:@"tip_amount"];
  LUMonetaryValue *total = [attributes lu_monetaryValueForKey:@"total_amount"];
  NSString *UUID = [attributes lu_stringForKey:@"uuid"];

  return [[LUOrderAheadViewableOrder alloc] initWithCompletionURL:completionURL
                                                         discount:discount
                                                 locationSubtitle:locationSubtitle
                                                    locationTitle:locationTitle
                                                       serviceFee:serviceFee
                                               soonestAvailableAt:soonestAvailableAt
                                                            spend:spend
                                                            state:state
                                                              tax:tax
                                                              tip:tip
                                                            total:total
                                                             UUID:UUID];
}

- (NSString *)rootKey {
  return @"order";
}

@end
