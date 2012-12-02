#import <Foundation/Foundation.h>

@class LUAPIRequest;

@interface LUOrderRequest : NSObject

+ (LUAPIRequest *)getOrdersForPage:(NSUInteger)page;
+ (LUAPIRequest *)getOrderWithId:(NSNumber *)orderId;

@end
