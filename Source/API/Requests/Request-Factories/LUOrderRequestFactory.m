#import "LUAPIClient.h"
#import "LUAuthenticatedAPIRequest.h"
#import "LUOrderJSONFactory.h"
#import "LUOrderRequestFactory.h"

@implementation LUOrderRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForOrdersAtMerchantWithID:(NSNumber *)merchantID page:(NSUInteger)page {
  NSString *path = [NSString stringWithFormat:@"users/%@/orders", [LUAPIClient sharedClient].currentUserID];

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"GET"
                                                    path:path
                                              apiVersion:LUAPIVersion13
                                              parameters:@{@"merchant_ids" : merchantID, @"page" : @(page)}
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

+ (LUAPIRequest *)requestForOrderWithID:(NSNumber *)orderID {
  NSString *path = [NSString stringWithFormat:@"orders/%@", orderID];

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"GET"
                                                    path:path
                                              apiVersion:LUAPIVersion13
                                              parameters:nil
                                            modelFactory:[LUOrderJSONFactory factory]];
}

@end
