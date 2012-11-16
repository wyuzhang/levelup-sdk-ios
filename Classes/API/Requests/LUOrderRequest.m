#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUOrderRequest.h"

@implementation LUOrderRequest

+ (LUAPIRequest *)getOrdersForPage:(NSUInteger)page {
  NSString *path = [NSString stringWithFormat:@"users/%@/orders", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest authenticatedApiRequestWithMethod:@"GET" path:path parameters:@{@"page" : @(page)}];
}

+ (LUAPIRequest *)getOrderWithId:(NSNumber *)orderId {
  NSString *path = [NSString stringWithFormat:@"orders/%@", orderId];

  return [LUAPIRequest authenticatedApiRequestWithMethod:@"GET" path:path parameters:nil];
}

@end
