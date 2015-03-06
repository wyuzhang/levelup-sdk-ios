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

#import <UIKit/UIKit.h>
#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUCampaignRepresentationBasicV1.h"

@implementation LUCampaignRepresentationBasicV1

#pragma mark - Creation

- (id)initWithCampaignDescription:(NSString *)campaignDescription campaignID:(NSNumber *)campaignID
                            title:(NSString *)title {
  self = [super init];
  if (!self) return nil;

  _campaignDescription = campaignDescription;
  _campaignID = campaignID;
  _title = title;

  return self;
}

#pragma mark - Public Methods

- (NSURL *)largeIconURL {
  return [self iconURLWithHeight:200 width:200];
}

- (NSURL *)mediumIconURL {
  return [self iconURLWithHeight:100 width:100];
}

- (NSURL *)smallIconURL {
  return [self iconURLWithHeight:50 width:50];
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUCampaignRepresentationBasicV1 [address=%p, campaignDescription=%@, campaignID=%@, title=%@]",
          self, self.campaignDescription, self.campaignID, self.title];
}

#pragma mark - Private Methods

- (NSURL *)iconURLWithHeight:(int)height width:(int)width {
  NSString *path = [NSString stringWithFormat:@"%@/campaigns/%@/icon?density=%d&height=%d&width=%d",
                    LUAPIVersion15, [self.campaignID stringValue], (int)[UIScreen mainScreen].scale,
                    height, width];

  return [NSURL URLWithString:path relativeToURL:[LUAPIClient sharedClient].baseURL];
}

@end
