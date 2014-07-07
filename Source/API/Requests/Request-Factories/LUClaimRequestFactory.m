// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUClaimJSONFactory.h"
#import "LUClaimRequestFactory.h"
#import "NSDictionary+SafetyAdditions.h"

@implementation LUClaimRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestToClaimCampaignWithCode:(NSString *)code {
  NSString *path = [NSString stringWithFormat:@"codes/%@/claims", code];

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:path
                                 apiVersion:LUAPIVersion15
                                 parameters:nil
                               modelFactory:[LUClaimJSONFactory factory]];
}

+ (LUAPIRequest *)requestToClaimLegacyLoyaltyWithID:(NSString *)legacyID campaignID:(NSNumber *)campaignID {
  NSString *path = [NSString stringWithFormat:@"loyalties/legacy/%@/claims", campaignID];

  NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
  [parameters lu_setSafeValue:@{@"legacy_id" : legacyID} forKey:@"legacy_loyalty"];

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:path
                                 apiVersion:LUAPIVersion15
                                 parameters:parameters
                               modelFactory:[LUClaimJSONFactory factory]];
}

@end
