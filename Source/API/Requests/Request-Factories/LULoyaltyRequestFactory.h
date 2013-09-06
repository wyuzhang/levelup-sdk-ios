/**
 `LULoyaltyRequestFactory` is used to build requests related to loyalty.
 */
@class LUAPIRequest;

@interface LULoyaltyRequestFactory : NSObject

/**
 Builds a request to retrieve the current user's loyalty at a specific merchant.

 When successful, an `LULoyalty` instance will be returned.

 @param merchantID The ID of the merchant whose loyalty will be requested.
 */
+ (LUAPIRequest *)requestForLoyaltyForMerchantWithID:(NSNumber *)merchantID;

@end
