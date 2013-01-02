#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUOrderRequest.h"

@implementation LUOrderRequest

+ (LUAPIRequest *)getOrdersForMerchantWithId:(NSNumber *)merchantId page:(NSUInteger)page {
  NSString *path = [NSString stringWithFormat:@"users/%@/orders", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:path parameters:@{@"merchant_ids" : merchantId, @"page" : @(page)}];
}

+ (LUAPIRequest *)getOrdersForPage:(NSUInteger)page {
  NSString *path = [NSString stringWithFormat:@"users/%@/orders", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:path parameters:@{@"page" : @(page)}];
}

+ (LUAPIRequest *)getOrderWithId:(NSNumber *)orderId {
  NSString *path = [NSString stringWithFormat:@"orders/%@", orderId];

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:path parameters:nil];
}

@end
