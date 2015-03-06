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

/**
 A basic representation of a campaign, containing a title, description and icon image.
 */
@interface LUCampaignRepresentationBasicV1 : LUAPIModel

/**
 A description of the campaign.
 */
@property (nonatomic, readonly, copy) NSString *campaignDescription;

/**
 The campaign's ID.
 */
@property (nonatomic, readonly, copy) NSNumber *campaignID;

/**
 The campaign's title.
 */
@property (nonatomic, readonly, copy) NSString *title;

/**
 The campaign's icon, at 200x200 points. `[UIScreen mainScreen].density` is used to determine the
 device's density, so on a 2x retina display this will return the URL for an image at 400x400 pixels.
 */
- (NSURL *)largeIconURL;

/**
 The campaign's icon, at 100x100 points. `[UIScreen mainScreen].density` is used to determine the
 device's density, so on a 2x retina display this will return the URL for an image at 200x200 pixels.
 */
- (NSURL *)mediumIconURL;

/**
 The campaign's icon, at 50x50 points. `[UIScreen mainScreen].density` is used to determine the
 device's density, so on a 2x retina display this will return the URL for an image at 100x100 pixels.
 */
- (NSURL *)smallIconURL;

- (id)initWithCampaignDescription:(NSString *)campaignDescription campaignID:(NSNumber *)campaignID
                            title:(NSString *)title;

@end
