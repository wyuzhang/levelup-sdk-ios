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

#import "LUAPIModel.h"

@class LUMonetaryValue;

/**
 A summary of the rewards available at a particular location. See `LUReward` for more information
 on rewards in general.
 */
@interface LURewardSummary : LUAPIModel

/**
 The total credit available through rewards.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *credit;

/**
 The total number of rewards available.
 */
@property (nonatomic, assign, readonly) NSInteger rewardCount;

/**
 The number of rewards that are usable as credit.
 */
@property (nonatomic, assign, readonly) NSInteger usableAsCreditRewardCount;

- (id)initWithCredit:(LUMonetaryValue *)credit rewardCount:(NSInteger)rewardCount
usableAsCreditRewardCount:(NSInteger)usableAsCreditRewardCount;

@end
