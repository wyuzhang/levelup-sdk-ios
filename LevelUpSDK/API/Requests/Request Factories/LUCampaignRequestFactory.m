#import "LUAPIRequest.h"
#import "LUCampaignJSONFactory.h"
#import "LUCampaignRequestFactory.h"

@implementation LUCampaignRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForCampaignWithId:(NSNumber *)campaignId {
  NSString *path = [NSString stringWithFormat:@"campaigns/%@", campaignId];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:path
                                 parameters:nil
                               modelFactory:[LUCampaignJSONFactory factory]];
}

@end
