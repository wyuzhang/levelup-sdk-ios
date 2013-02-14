/**
 `LUCampaignRequestBuilder` is used to build requests related to campaigns.
 */
@class LUAPIRequest;

@interface LUCampaignRequestBuilder : NSObject

/**
 Builds a request to retrieve a campaign.

 On success, this request will return the requested `LUCampaign` instance.

 @param campaignId The ID of the campaign to retrieve.
 */
+ (LUAPIRequest *)requestForCampaignWithId:(NSNumber *)campaignId;

@end
