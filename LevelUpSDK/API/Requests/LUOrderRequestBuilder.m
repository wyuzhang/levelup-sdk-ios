#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUOrderRequestBuilder.h"

@implementation LUOrderRequestBuilder

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForOrdersAtMerchantWithId:(NSNumber *)merchantId page:(NSUInteger)page {
  NSString *path = [NSString stringWithFormat:@"users/%@/orders", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:path parameters:@{@"merchant_ids" : merchantId, @"page" : @(page)}];
}

+ (LUAPIRequest *)requestForOrdersOnPage:(NSUInteger)page {
  NSString *path = [NSString stringWithFormat:@"users/%@/orders", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:path parameters:@{@"page" : @(page)}];
}

+ (LUAPIRequest *)requestForOrderWithId:(NSNumber *)orderId {
  NSString *path = [NSString stringWithFormat:@"orders/%@", orderId];

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:path parameters:nil];
}

@end
