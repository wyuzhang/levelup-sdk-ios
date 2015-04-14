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

#import "LUCampaignRepresentationVisitBasedLoyaltyV1.h"
#import "LUCampaignRepresentationVisitBasedLoyaltyV1JSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCampaignRepresentationVisitBasedLoyaltyV1JSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  LUMonetaryValue *earn = [attributes lu_monetaryValueForKey:@"earn_amount"];
  NSUInteger progressVisitCount = [[attributes lu_numberForKey:@"progress_visit_count"] unsignedIntegerValue];
  LUMonetaryValue *qualifyingOrderSpend = [attributes lu_monetaryValueForKey:@"qualifying_order_spend_amount"];
  NSUInteger requiredVisitCount = [[attributes lu_numberForKey:@"required_visit_count"] unsignedIntegerValue];

  return [[LUCampaignRepresentationVisitBasedLoyaltyV1 alloc] initWithCampaignID:self.campaignID
                                                                            earn:earn
                                                              progressVisitCount:progressVisitCount
                                                            qualifyingOrderSpend:qualifyingOrderSpend
                                                              requiredVisitCount:requiredVisitCount];
}

@end
