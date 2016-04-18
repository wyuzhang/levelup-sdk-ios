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

#import "LUReward.h"
#import "LURewardJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LURewardJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSDate *createdAtDate = [attributes lu_dateForKey:@"created_at"];
  NSDate *expiresAtDate = [attributes lu_dateForKey:@"expires_at"];
  NSString *rewardDescription = [attributes lu_stringForKey:@"description"];
  NSString *rewardID = [attributes lu_stringForKey:@"id"];
  NSNumber *sourceCampaignID = [attributes lu_numberForKey:@"source_campaign_id"];
  NSArray *tags = [attributes lu_arrayForKey:@"tags"];
  NSString *title = [attributes lu_stringForKey:@"title"];
  BOOL usable = [attributes lu_boolForKey:@"usable"];
  BOOL usableAsCredit = [attributes lu_boolForKey:@"usable_as_credit"];
  BOOL usableNow = [attributes lu_boolForKey:@"usable_now"];
  LUMonetaryValue *valueRemaining = [attributes lu_monetaryValueForKey:@"value_remaining_amount"];

  return [[LUReward alloc] initWithCreatedAtDate:createdAtDate expiresAtDate:expiresAtDate
                               rewardDescription:rewardDescription rewardID:rewardID
                                sourceCampaignID:sourceCampaignID tags:tags title:title
                                          usable:usable usableAsCredit:usableAsCredit
                                       usableNow:usableNow valueRemaining:valueRemaining];
}

- (NSString *)rootKey {
  return @"reward";
}

@end
