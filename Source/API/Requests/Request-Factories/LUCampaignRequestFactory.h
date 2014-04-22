// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@class LUAPIRequest;

/**
 `LUCampaignRequestFactory` is used to build requests related to campaigns.
 */
@interface LUCampaignRequestFactory : NSObject

/**
 Builds a request to retrieve the merchants associated with the campaign. Only the merchant IDs are
 returned; they are represented as an `NSArray` of `NSNumber` instances. If the campaign is global
 (it applies to all merchants), then this request will return `nil`.

 @param campaignID The ID of the campaign whose merchants will be retrieved.
 */
+ (LUAPIRequest *)requestForMerchantsForCampaignWithID:(NSNumber *)campaignID;

/**
 Builds a request to retrieve a campaign by its code. This is most commonly used when a user has
 scanned a QR code for the campaign. The value retrieved from the QR code can be used with this
 request to retrieve the associated campaign.

 On success, this request will return the requested `LUCampaign` instance.

 @param code The code of the campaign to retrieve.
 */
+ (LUAPIRequest *)requestForCampaignWithCode:(NSString *)code;

/**
 Builds a request to retrieve a campaign by its unique ID.

 On success, this request will return the requested `LUCampaign` instance.

 @param campaignID The ID of the campaign to retrieve.
 */
+ (LUAPIRequest *)requestForCampaignWithID:(NSNumber *)campaignID;

@end
