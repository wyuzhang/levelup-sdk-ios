// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUOrderJSONFactory.h"
#import "LUOrderRequestFactory.h"
#import "NSURL+LUAdditions.h"

@implementation LUOrderRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForOrders {
  NSString *path = [NSString stringWithFormat:@"apps/%@/orders", [LUAPIClient sharedClient].appID];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:path
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LUOrderJSONFactory factory]];
}

+ (LUAPIRequest *)requestForOrdersOnPage:(NSURL *)pageURL {
  if (!pageURL) return [self requestForOrders];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:[pageURL lu_pathAndQueryWithoutAPIVersion]
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LUOrderJSONFactory factory]];
}

+ (LUAPIRequest *)requestForOrderWithUUID:(NSString *)UUID {
  NSString *path = [NSString stringWithFormat:@"orders/%@", UUID];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:path
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LUOrderJSONFactory factory]];
}

@end
