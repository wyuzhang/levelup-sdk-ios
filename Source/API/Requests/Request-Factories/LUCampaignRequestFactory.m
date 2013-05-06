#import "LUAuthenticatedAPIRequest.h"
#import "LUCampaignJSONFactory.h"
#import "LUCampaignRequestFactory.h"

@implementation LUCampaignRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForCampaignWithId:(NSNumber *)campaignId {
  NSString *path = [NSString stringWithFormat:@"campaigns/%@", campaignId];

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"GET"
                                                    path:path
                                              apiVersion:LUAPIVersion13
                                              parameters:nil
                                            modelFactory:[LUCampaignJSONFactory factory]];
}

@end
