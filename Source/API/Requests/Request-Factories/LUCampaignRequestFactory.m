/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
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

#import "LUAPIRequest.h"
#import "LUCampaignJSONFactory.h"
#import "LUCampaignMetadataJSONFactory.h"
#import "LUCampaignRepresentationBasicV1JSONFactory.h"
#import "LUCampaignRepresentationSpendBasedLoyaltyV1JSONFactory.h"
#import "LUCampaignRepresentationVisitBasedLoyaltyV1JSONFactory.h"
#import "LUCampaignRequestFactory.h"

@implementation LUCampaignRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForCampaignMetadataForLocationWithID:(NSNumber *)locationID {
  NSString *path = [NSString stringWithFormat:@"locations/%@/campaigns", [locationID stringValue]];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:path
                                 apiVersion:LUAPIVersion15
                                 parameters:nil
                               modelFactory:[LUCampaignMetadataJSONFactory factory]];
}

+ (LUAPIRequest *)requestForCampaignMetadataForMerchantWithID:(NSNumber *)merchantID {
  NSString *path = [NSString stringWithFormat:@"merchants/%@/campaigns", [merchantID stringValue]];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:path
                                 apiVersion:LUAPIVersion15
                                 parameters:nil
                               modelFactory:[LUCampaignMetadataJSONFactory factory]];
}

+ (LUAPIRequest *)requestForCampaignWithCode:(NSString *)code {
  NSString *path = [NSString stringWithFormat:@"codes/%@/campaign", code];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:path
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LUCampaignJSONFactory factory]];
}

+ (LUAPIRequest *)requestForCampaignWithID:(NSNumber *)campaignID {
  NSString *path = [NSString stringWithFormat:@"campaigns/%@", [campaignID stringValue]];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:path
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LUCampaignJSONFactory factory]];
}

+ (LUAPIRequest *)requestForCampaignWithMetadata:(LUCampaignMetadata *)campaignMetadata
                              representationType:(LUCampaignRepresentationType)representationType {
  BOOL representationTypeInMetadata = NO;
  for (id representationTypeObj in campaignMetadata.representationTypes) {
    if (representationType == [representationTypeObj integerValue]) {
      representationTypeInMetadata = YES;
      break;
    }
  }

  NSAssert(representationTypeInMetadata, @"Representation type is not in campaign metadata.");
  if (!representationTypeInMetadata) {
    return nil;
  }

  NSString *path = [NSString stringWithFormat:@"campaigns/%@/%@", campaignMetadata.campaignID,
                    [LUCampaignMetadata stringForCampaignRepresentationType:representationType]];

  LUAbstractJSONModelFactory *modelFactory;
  switch (representationType) {
    case LUCampaignRepresentationTypeBasicV1:
      modelFactory = [LUCampaignRepresentationBasicV1JSONFactory factoryWithCampaignID:campaignMetadata.campaignID];
      break;

    case LUCampaignRepresentationTypeSpendBasedLoyaltyV1:
      modelFactory = [LUCampaignRepresentationSpendBasedLoyaltyV1JSONFactory factoryWithCampaignID:campaignMetadata.campaignID];
      break;

    case LUCampaignRepresentationTypeVisitBasedLoyaltyV1:
      modelFactory = [LUCampaignRepresentationVisitBasedLoyaltyV1JSONFactory factoryWithCampaignID:campaignMetadata.campaignID];
      break;
  }

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:path
                                 apiVersion:LUAPIVersion15
                                 parameters:nil
                               modelFactory:modelFactory];
}

+ (LUAPIRequest *)requestForMerchantsForCampaignWithID:(NSNumber *)campaignID {
  NSString *path = [NSString stringWithFormat:@"campaigns/%@/merchants", [campaignID stringValue]];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:path
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:nil];
}

@end
