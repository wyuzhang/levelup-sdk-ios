@class LUAPIRequest;

@interface LUOrderRequestBuilder : NSObject

+ (LUAPIRequest *)requestForOrdersAtMerchantWithId:(NSNumber *)merchantId page:(NSUInteger)page;
+ (LUAPIRequest *)requestForOrdersOnPage:(NSUInteger)page;
+ (LUAPIRequest *)requestForOrderWithId:(NSNumber *)orderId;

@end
