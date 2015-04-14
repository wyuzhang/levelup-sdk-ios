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
 A representation of a spend based loyalty campaign, which means that credit is earned each time a
 specific amount of money is spent at the merchant.
 */
@interface LUCampaignRepresentationSpendBasedLoyaltyV1 : LUAPIModel

/**
 The campaign's ID.
 */
@property (nonatomic, readonly, copy) NSNumber *campaignID;

/**
 The amount of money earned each time `requiredSpend` is spent.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *earn;

/**
 The user's progress towards unlocking credit.

 After unlocking credit, this amount will cycle back to zero. For example, say `requiredSpend` is
 $50. As the user spends money, `progress` moves towards $50. Once they have spent over $50,
 they unlock credit, and then `progress` cycles back to $0 and then continues to move back towards
 $50 as more money is spent.

 If this campaign representation is requested without an authenticated user, `progress` will always
 be $0.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *progress;

/**
 The amount of money that must be spent in order to unlock credit.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *requiredSpend;

- (id)initWithCampaignID:(NSNumber *)campaignID earn:(LUMonetaryValue *)earn
                progress:(LUMonetaryValue *)progress requiredSpend:(LUMonetaryValue *)requiredSpend;

@end
