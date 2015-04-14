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
 A representation of a visit based loyalty campaign, which means that credit is unlocked every time
 the user visits the merchant a certain number of times. "Visiting" means placing an order greater
 than or equal to the qualifying spend amount at the merchant.
 */
@interface LUCampaignRepresentationVisitBasedLoyaltyV1 : LUAPIModel

/**
 The campaign's ID.
 */
@property (nonatomic, readonly, copy) NSNumber *campaignID;

/**
 The amount of money earned after visiting enough times to unlock credit.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *earn;

/**
 The user's progress towards unlocking credit.

 After unlocking credit, this number will cycle back to zero. For example, say `requiredVisitCount`
 is 10. As the user visits the merchant, `progressVisitCount` moves 10. Once they have visited 10
 times, they unlock credit, and then `progressVisitCount` cycles back to 0 and continues to move
 towards 10 as more visits occur.

 If this campaign representation is requested without an authenticated user, `progressVisitCount`
 will always be 0.
 */
@property (nonatomic, assign, readonly) NSUInteger progressVisitCount;

/**
 The minimum amount of money that must be spent for an order to qualify as a "visit".

 If there is no minimum amount, this will be $0.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *qualifyingOrderSpend;

/**
 The number of visits a user must make at the merchant in order to unlock credit.
 */
@property (nonatomic, assign, readonly) NSUInteger requiredVisitCount;

- (id)initWithCampaignID:(NSNumber *)campaignID earn:(LUMonetaryValue *)earn
      progressVisitCount:(NSUInteger)progressVisitCount
    qualifyingOrderSpend:(LUMonetaryValue *)qualifyingOrderSpend
      requiredVisitCount:(NSUInteger)requiredVisitCount;

@end
