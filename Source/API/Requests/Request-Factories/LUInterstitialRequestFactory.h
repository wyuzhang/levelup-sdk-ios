/**
 `LULocationRequestFactory` builds requests to retrieve interstitials.
 */
@class LUAPIRequest;

@interface LUInterstitialRequestFactory : NSObject

/**
 Builds a request for an interstitial for an order with the given UUID.

 If this order does not have an interestitial, this request will fail with the error code `LUAPIErrorNotFound`.

 @param UUID The UUID of an order.
 */
+ (LUAPIRequest *)requestForInterstitialForOrderWithUUID:(NSString *)UUID;

@end
