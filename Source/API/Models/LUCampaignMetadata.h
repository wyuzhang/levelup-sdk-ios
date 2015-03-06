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

/** Campaign representation types. */
typedef NS_ENUM(NSInteger, LUCampaignRepresentationType) {
  /** A basic representation containing a title, description and icon. */
  LUCampaignRepresentationTypeBasicV1
};

/**
 Contains a campaign's ID a list of its possible representation types (see
 `LUCampaignRepresentationType`).
 */
@interface LUCampaignMetadata : LUAPIModel

/**
 The campaign's ID.
 */
@property (nonatomic, copy, readonly) NSNumber *campaignID;

/**
 An `NSArray` of `LUCampaignRepresentationType` values.
 */
@property (nonatomic, strong, readonly) NSArray *representationTypes;

+ (LUCampaignRepresentationType)campaignRepresentationTypeForString:(NSString *)string;
+ (NSString *)stringForCampaignRepresentationType:(LUCampaignRepresentationType)type;

- (id)initWithCampaignID:(NSNumber *)campaignID representationTypes:(NSArray *)representationTypes;

@end
