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

#import "LUCampaignMetadata.h"
#import "LUCampaignMetadataJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCampaignMetadataJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSNumber *campaignID = [attributes lu_numberForKey:@"id"];
  NSArray *representationTypeStrings = [attributes lu_arrayForKey:@"representation_types"];

  NSMutableArray *representationTypes = [NSMutableArray array];
  for (NSString *typeString in representationTypeStrings) {
    [representationTypes addObject:@([LUCampaignMetadata campaignRepresentationTypeForString:typeString])];
  }

  return [[LUCampaignMetadata alloc] initWithCampaignID:campaignID representationTypes:representationTypes];
}

- (NSString *)rootKey {
  return @"campaign";
}

@end
