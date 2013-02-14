/**
 `LUOrderRequestBuilder` is used to build requests related to retrieving orders.
 */
@class LUAPIRequest;

@interface LUOrderRequestBuilder : NSObject

/**
 Builds a request to retrieve orders that the current user has made at a given merchant.

 On success, this request will return an array of `LUOrder` instances.

 @param merchantId The ID of the merchant to search against.
 @param page The page of orders to retrieve.
 */
+ (LUAPIRequest *)requestForOrdersAtMerchantWithId:(NSNumber *)merchantId page:(NSUInteger)page;

/**
 Builds a request to retrieve orders of the current user.

 On success, this request will return an array of `LUOrder` instances.

 @param page The page of orders to retrieve.
 */
+ (LUAPIRequest *)requestForOrdersOnPage:(NSUInteger)page;

/**
 Builds a request to retrieve an order.

 On success, this request will return an `LUOrder` instance.

 @param orderId The ID of the order to retrieve.
 */
+ (LUAPIRequest *)requestForOrderWithId:(NSNumber *)orderId;

@end
