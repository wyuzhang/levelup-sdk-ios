// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAuthenticatedAPIRequest.h"
#import "LUCampaignJSONFactory.h"
#import "LUCampaignRequestFactory.h"

@implementation LUCampaignRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForMerchantsForCampaignWithID:(NSNumber *)campaignID {
  NSString *path = [NSString stringWithFormat:@"campaigns/%@/merchants", [campaignID stringValue]];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:path
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:nil];
}

+ (LUAPIRequest *)requestForCampaignWithCode:(NSString *)code {
  NSString *path = [NSString stringWithFormat:@"codes/%@/campaign", code];

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"GET"
                                                    path:path
                                              apiVersion:LUAPIVersion14
                                              parameters:nil
                                            modelFactory:[LUCampaignJSONFactory factory]];
}

+ (LUAPIRequest *)requestForCampaignWithID:(NSNumber *)campaignID {
  NSString *path = [NSString stringWithFormat:@"campaigns/%@", [campaignID stringValue]];

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"GET"
                                                    path:path
                                              apiVersion:LUAPIVersion14
                                              parameters:nil
                                            modelFactory:[LUCampaignJSONFactory factory]];
}

@end
