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

#import "LUMonetaryValue.h"
#import "LUReward+Fixtures.h"
#import "NSDate+StringFormats.h"

@implementation LUReward (Fixtures)

+ (LUReward *)fixture {
  return [[LUReward alloc] initWithCreatedAtDate:[NSDate lu_dateFromIso8601DateTimeString:@"2012-12-24T16:58:23-05:00"]
                                   expiresAtDate:[NSDate lu_dateFromIso8601DateTimeString:@"2012-12-24T16:58:23-05:00"]
                               rewardDescription:@"$2 Onboarding credit"
                                        rewardID:@"campaign-1"
                                sourceCampaignID:@1
                                            tags:@[@"custom", @"merchant_funded"]
                                           title:@"Onboarding"
                                          usable:YES
                                  usableAsCredit:YES
                                       usableNow:YES
                                  valueRemaining:[LUMonetaryValue monetaryValueWithUSCents:@200]];
}

@end
