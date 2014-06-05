// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

@class LUAPIRequest;

/**
 `LULoyaltyRequestFactory` is used to build requests related to loyalty.
 */
@interface LULoyaltyRequestFactory : NSObject

/**
 Builds a request to retrieve the current user's loyalty at a specific merchant.

 When successful, an `LULoyalty` instance will be returned.

 @warning This request requires an access token with the `manage_campaigns` permission.
 @param merchantID The ID of the merchant whose loyalty will be requested.
 */
+ (LUAPIRequest *)requestForLoyaltyForMerchantWithID:(NSNumber *)merchantID;

@end
