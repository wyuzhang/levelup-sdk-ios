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

#import "LUCampaignRepresentationBasicV1.h"
#import "LUCampaignRepresentationBasicV1JSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCampaignRepresentationBasicV1JSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *campaignDescription = [attributes lu_stringForKey:@"description"];
  NSString *title = [attributes lu_stringForKey:@"title"];

  return [[LUCampaignRepresentationBasicV1 alloc] initWithCampaignDescription:campaignDescription
                                                                   campaignID:self.campaignID
                                                                        title:title];
}

@end
