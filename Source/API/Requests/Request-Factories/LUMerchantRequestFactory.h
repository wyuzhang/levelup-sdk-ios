/**
 `LUMerchantRequestFactory` is used to build requests related to merchants.
 */
@class CLLocation;
@class LUAPIRequest;
@class LUCategory;

@interface LUMerchantRequestFactory : NSObject

/**
 Builds a request to retrieve all merchants at which the current user has previously placed orders.

 On success, this request will return an array of `LUMerchant` instances.

 @param page The page of merchants to retrieve.
 */
+ (LUAPIRequest *)requestForUserMerchantsOnPage:(NSUInteger)page;

/**
 Builds a request to retrieve all merchants near a location. The exact radius may change, but is currently 50 miles.

 On success, this request will return an array of `LUMerchant` instances.

 @param location A `CLLocation` to use as the center of the search circle.
 @param page The page of merchants to retrieve.
 */
+ (LUAPIRequest *)requestForMerchantsNearLocation:(CLLocation *)location page:(NSUInteger)page;

/**
 Builds a request to retrieve all merchants near a location, within a given category. The exact radius may change, but
 is currently 50 miles.

 On success, this request will return an array of `LUMerchant` instances.

 @param location A `CLLocation` to use as the center of the search circle.
 @param category The `LUCategory` of merchants to retrieve.
 @param page The page of merchants to retrieve.
 */
+ (LUAPIRequest *)requestForMerchantsNearLocation:(CLLocation *)location inCategory:(LUCategory *)category page:(NSUInteger)page;

/**
 Builds a request to retrieve a merchant.

 On success, this request will return an `LUMerchant` instance.

 @param merchantId The ID of the merchant to retrieve.
 */
+ (LUAPIRequest *)requestForMerchantWithId:(NSNumber *)merchantId;

@end
