#import "LUAPIClient.h"
#import "LUAuthenticatedAPIRequest.h"
#import "LUOrderJSONFactory.h"
#import "LUOrderRequestFactory.h"

@implementation LUOrderRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForOrdersAtMerchantWithId:(NSNumber *)merchantId page:(NSUInteger)page {
  NSString *path = [NSString stringWithFormat:@"users/%@/orders", [LUAPIClient sharedClient].currentUserID];

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"GET"
                                                    path:path
                                              apiVersion:LUAPIVersion13
                                              parameters:@{@"merchant_ids" : merchantId, @"page" : @(page)}
                                            modelFactory:[LUOrderJSONFactory factory]];
}

+ (LUAPIRequest *)requestForOrdersOnPage:(NSUInteger)page {
  NSString *path = [NSString stringWithFormat:@"users/%@/orders", [LUAPIClient sharedClient].currentUserID];

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"GET"
                                                    path:path
                                              apiVersion:LUAPIVersion13
                                              parameters:@{@"page" : @(page)}
                                            modelFactory:[LUOrderJSONFactory factory]];
}

+ (LUAPIRequest *)requestForOrderWithId:(NSNumber *)orderId {
  NSString *path = [NSString stringWithFormat:@"orders/%@", orderId];

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"GET"
                                                    path:path
                                              apiVersion:LUAPIVersion13
                                              parameters:nil
                                            modelFactory:[LUOrderJSONFactory factory]];
}

@end
