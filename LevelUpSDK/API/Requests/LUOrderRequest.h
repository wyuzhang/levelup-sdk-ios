#import <Foundation/Foundation.h>

@class LUAPIRequest;

@interface LUOrderRequest : NSObject

+ (LUAPIRequest *)getOrdersForMerchantWithId:(NSNumber *)merchantId page:(NSUInteger)page;
+ (LUAPIRequest *)getOrdersForPage:(NSUInteger)page;
+ (LUAPIRequest *)getOrderWithId:(NSNumber *)orderId;

@end
