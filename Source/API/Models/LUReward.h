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
 In general, a reward can represent anything that a user is happy to have. Often this will include
 credit, but could also include things like discounts on specific items.
 */
@interface LUReward : LUAPIModel

/**
 The date the reward was created.
 */
@property (nonatomic, copy, readonly) NSDate *createdAtDate;

/**
 The reward's expiration date. Can be `nil` if the reward doesn't expire.
 */
@property (nonatomic, copy, readonly) NSDate *expiresAtDate;

/**
 A human-readable description of the reward.
 */
@property (nonatomic, copy, readonly) NSString *rewardDescription;

/**
 The unique identifier for this reward.
 */
@property (nonatomic, copy, readonly) NSString *rewardID;

/**
 If this reward was created by a campaign, that campaign's ID. Otherwise will be `nil`.
 */
@property (nonatomic, copy, readonly) NSNumber *sourceCampaignID;

/**
 An array of tag names (as `NSString`s).
 */
@property (nonatomic, copy, readonly) NSArray *tags;

/**
 A human-readable title for this reward.
 */
@property (nonatomic, copy, readonly) NSString *title;

/**
 Whether or not this reward can be used (i.e. consumed). For example, a reward of loyalty credit can
 be used, whereas a reward of unlocking a campaign is not used.
 */
@property (nonatomic, assign, readonly) BOOL usable;

/**
 Whether or not this reward contributes to credit.
 */
@property (nonatomic, assign, readonly) BOOL usableAsCredit;

/**
 Whether or not this reward can be used right now.
 */
@property (nonatomic, assign, readonly) BOOL usableNow;

/**
 The value remaining on a reward, if it has a monetary value.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *valueRemaining;

/**
 The reward's icon, at 200x200 points. `[UIScreen mainScreen].density` is used to determine the
 device's density, so on a 2x retina display this will return the URL for an image at 400x400 pixels.
 */
- (NSURL *)largeIconURL;

/**
 The reward's icon, at 100x100 points. `[UIScreen mainScreen].density` is used to determine the
 device's density, so on a 2x retina display this will return the URL for an image at 200x200 pixels.
 */
- (NSURL *)mediumIconURL;

/**
 The reward's icon, at 50x50 points. `[UIScreen mainScreen].density` is used to determine the
 device's density, so on a 2x retina display this will return the URL for an image at 100x100 pixels.
 */
- (NSURL *)smallIconURL;

- (id)initWithCreatedAtDate:(NSDate *)createdAtDate expiresAtDate:(NSDate *)expiresAtDate
          rewardDescription:(NSString *)rewardDescription rewardID:(NSString *)rewardID
           sourceCampaignID:(NSNumber *)sourceCampaignID tags:(NSArray *)tags
                      title:(NSString *)title usable:(BOOL)usable usableAsCredit:(BOOL)usableAsCredit
                  usableNow:(BOOL)usableNow valueRemaining:(LUMonetaryValue *)valueRemaining;

@end
