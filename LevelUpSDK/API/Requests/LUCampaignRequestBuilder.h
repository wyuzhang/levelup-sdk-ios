@class LUAPIRequest;

@interface LUCampaignRequestBuilder : NSObject

+ (LUAPIRequest *)requestForCampaignWithId:(NSNumber *)campaignId;

@end
