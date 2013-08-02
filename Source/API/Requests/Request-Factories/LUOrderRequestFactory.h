/**
 `LUOrderRequestFactory` is used to build requests related to retrieving orders.
 */
@class LUAPIRequest;

@interface LUOrderRequestFactory : NSObject

/**
 Builds a request to retrieve orders that the current user has made at merchants associated with the app.

 On success, this request will return an array of `LUOrder` instances. The response will include a URL for the next page
 of results. This URL can be used with `requestForOrdersOnPage:` to retrieve the next page of orders.
 */
+ (LUAPIRequest *)requestForOrders;

/**
 Builds a request to retrieve the given page of orders.

 On success, this request will return an array of `LUOrder` instances. If this page doesn't include any orders, the
 response will be empty with a status code of 204 (No Content).

 @param pageURL The next page of orders to request.
 */
+ (LUAPIRequest *)requestForOrdersOnPage:(NSURL *)pageURL;

/**
 Builds a request to retrieve an order.

 On success, this request will return an `LUOrder` instance.

 @param UUID The UUID of the order to retrieve.
 */
+ (LUAPIRequest *)requestForOrderWithUUID:(NSString *)UUID;

@end
