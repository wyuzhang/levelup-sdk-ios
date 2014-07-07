// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@class LUAPIRequest;

/**
 `LUClaimRequestFactory` is used to build requests related to claims.
 */
@interface LUClaimRequestFactory : NSObject

/**
 Builds a request to claim a campaign.

 On success, this request will return an instance of `LUClaim`.

 @warning This request requires an access token with the `manage_user_campaigns` permission.
 @param code The code of the campaign to claim.
 */
+ (LUAPIRequest *)requestToClaimCampaignWithCode:(NSString *)code;

/**
 Builds a request to claim a legacy loyalty campaign.

 On success, this request will return an `LUClaim`.

 @warning This request requires an access token with the `manage_user_campaigns` permission.
 @param legacyID An identifying string. For example, a user's loyalty card number.
 @param campaignID The ID of the campaign to claim.
 */
+ (LUAPIRequest *)requestToClaimLegacyLoyaltyWithID:(NSString *)legacyID campaignID:(NSNumber *)campaignID;

@end
