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

#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUMonetaryValue.h"
#import "LUReward.h"

@implementation LUReward

#pragma mark - Creation

- (id)initWithCreatedAtDate:(NSDate *)createdAtDate expiresAtDate:(NSDate *)expiresAtDate
          rewardDescription:(NSString *)rewardDescription rewardID:(NSString *)rewardID
           sourceCampaignID:(NSNumber *)sourceCampaignID title:(NSString *)title usable:(BOOL)usable
             usableAsCredit:(BOOL)usableAsCredit usableNow:(BOOL)usableNow
             valueRemaining:(LUMonetaryValue *)valueRemaining {
  self = [super init];
  if (!self) return nil;

  _createdAtDate = createdAtDate;
  _expiresAtDate = expiresAtDate;
  _rewardDescription = rewardDescription;
  _rewardID = rewardID;
  _sourceCampaignID = sourceCampaignID;
  _title = title;
  _usable = usable;
  _usableAsCredit = usableAsCredit;
  _usableNow = usableNow;
  _valueRemaining = valueRemaining;

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

- (NSString *)debugDescription {
  return [NSString stringWithFormat:@"LUReward [address=%p, createdAtDate=%@, expiresAtDate=%@, rewardDescription=%@, rewardID=%@, sourceCampaignID=%@, title=%@, usable=%@, usableAsCredit=%@, usableNow=%@, valueRemaining=%@]",
          self, self.createdAtDate, self.expiresAtDate, self.rewardDescription, self.rewardID,
          self.sourceCampaignID, self.title, @(self.usable), @(self.usableAsCredit),
          @(self.usableNow), self.valueRemaining];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUReward [address=%p, rewardDescription=%@, title=%@]",
          self, self.rewardDescription, self.title];
}

#pragma mark - Private Methods

- (NSURL *)iconURLWithHeight:(int)height width:(int)width {
  NSString *path = [NSString stringWithFormat:@"%@/rewards/%@/icon?density=%d&height=%d&width=%d",
                    LUAPIVersion15, self.rewardID, (int)[UIScreen mainScreen].scale, height, width];

  return [NSURL URLWithString:path relativeToURL:[LUAPIClient sharedClient].baseURL];
}

@end
