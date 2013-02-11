#import "LUAPIRequest.h"
#import "LUCampaignRequestBuilder.h"

@implementation LUCampaignRequestBuilder

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForCampaignWithId:(NSNumber *)campaignId {
  NSString *path = [NSString stringWithFormat:@"campaigns/%@", campaignId];

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:path parameters:nil];
}

@end
