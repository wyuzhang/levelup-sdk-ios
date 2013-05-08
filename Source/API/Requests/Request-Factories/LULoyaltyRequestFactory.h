@class LUAPIRequest;

@interface LULoyaltyRequestFactory : NSObject

+ (LUAPIRequest *)requestForLoyaltyForMerchantWithID:(NSNumber *)merchantID;

@end
