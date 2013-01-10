#import "LUAPIRequest.h"
#import "LUCampaignRequest.h"

@implementation LUCampaignRequest

+ (LUAPIRequest *)getCampaignWithId:(NSNumber *)campaignId {
  NSString *path = [NSString stringWithFormat:@"campaigns/%@", campaignId];

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:path parameters:nil];
}

@end
