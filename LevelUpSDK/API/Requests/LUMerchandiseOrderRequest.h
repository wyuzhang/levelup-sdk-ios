@class LUAPIRequest;
@class LUMerchandiseOrder;

@interface LUMerchandiseOrderRequest : NSObject

+ (LUAPIRequest *)createMerchandiseOrder:(LUMerchandiseOrder *)merchandiseOrder;

@end
