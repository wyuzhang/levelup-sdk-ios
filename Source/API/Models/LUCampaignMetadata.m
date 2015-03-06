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
#import "LUCampaignRepresentationTypeTransformer.h"
#import "NSArray+LUAdditions.h"

@implementation LUCampaignMetadata

#pragma mark - Creation

+ (void)load {
  [NSValueTransformer setValueTransformer:[[LUCampaignRepresentationTypeTransformer alloc] init]
                                  forName:LUCampaignRepresentationTypeTransformerName];
}

- (id)initWithCampaignID:(NSNumber *)campaignID representationTypes:(NSArray *)representationTypes {
  self = [super init];
  if (!self) return nil;

  _campaignID = campaignID;
  _representationTypes = representationTypes;

  return self;
}

#pragma mark - Public Methods

+ (LUCampaignRepresentationType)campaignRepresentationTypeForString:(NSString *)string {
  NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:LUCampaignRepresentationTypeTransformerName];
  return [[transformer reverseTransformedValue:string] integerValue];
}

+ (NSString *)stringForCampaignRepresentationType:(LUCampaignRepresentationType)type {
  NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:LUCampaignRepresentationTypeTransformerName];
  return [transformer transformedValue:@(type)];
}

#pragma mark - NSObject Methods

- (NSString *)description {
  NSArray *representationTypeStrings = [self.representationTypes lu_mappedArrayWithBlock:^id(id obj) {
    return [[self class] stringForCampaignRepresentationType:[obj integerValue]];
  }];

  return [NSString stringWithFormat:@"LUCampaignMetadata [address=%p, campaignID=%@, representationTypes=%@]",
          self, self.campaignID, representationTypeStrings];
}

@end
