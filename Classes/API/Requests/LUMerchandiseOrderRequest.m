#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUMerchandiseOrder.h"
#import "LUMerchandiseOrderRequest.h"

@implementation LUMerchandiseOrderRequest

+ (LUAPIRequest *)createMerchandiseOrder:(LUMerchandiseOrder *)merchandiseOrder {
  NSString *path = [NSString stringWithFormat:@"users/%@/merchandise_orders", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest authenticatedApiRequestWithMethod:@"POST" path:path parameters:@{@"merchandise_order" : merchandiseOrder.parameters}];
}

@end
