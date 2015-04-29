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

@class LUAPIRequest;

/**
 `LUCampaignRequestFactory` is used to build requests related to rewards.
 */
@interface LURewardRequestFactory : NSObject

/**
 Builds a request to return a summary of the rewards available at the location with the given `locationID`.

 On success, this request will return an instance of `LURewardSummary`.

 @param locationID The ID of the location whose reward summary will be retrieved.
 */
+ (LUAPIRequest *)requestForRewardSummaryAtLocationID:(NSNumber *)locationID;

/**
 Builds a request to return the rewards available at the location with the given `locationID`.

 On success, this request will return an `NSArray` of `LUReward` instances.

 @param locationID The ID of the location whose rewards will be retrieved.
 */
+ (LUAPIRequest *)requestForRewardsAtLocationID:(NSNumber *)locationID;

@end
