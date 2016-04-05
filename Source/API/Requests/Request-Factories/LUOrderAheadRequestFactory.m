/*
 * Copyright (C) 2016 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "LUAPIRequest.h"
#import "LULocationJSONFactory.h"
#import "LUOrderAheadCompletedOrderJSONFactory.h"
#import "LUOrderAheadMenu.h"
#import "LUOrderAheadMenuJSONFactory.h"
#import "LUOrderAheadOrder.h"
#import "LUOrderAheadOrderStatusJSONFactory.h"
#import "LUOrderAheadRequestFactory.h"
#import "LUOrderAheadSuggestedOrder.h"
#import "LUOrderAheadSuggestedOrderJSONFactory.h"
#import "LUOrderAheadViewableOrderJSONFactory.h"
#import "LUOrderJSONFactory.h"
#import "NSDictionary+SafetyAdditions.h"

@implementation LUOrderAheadRequestFactory

+ (LUAPIRequest *)requestForCompletedOrderWithURL:(NSURL *)URL {
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                        URL:URL
                                 parameters:nil
                               modelFactory:[LUOrderAheadCompletedOrderJSONFactory factory]
                         retryResponseCodes:@[@202]
                          retryTimeInterval:0.5];
}

+ (LUAPIRequest *)requestForDeliveryLocationForUserAddressWithID:(NSNumber *)addressID {
  NSString *path = [NSString stringWithFormat:@"user_addresses/%@/delivery_location", addressID];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:path
                                 apiVersion:LUAPIVersion15
                                 parameters:nil
                               modelFactory:[LULocationJSONFactory factory]];
}

+ (LUAPIRequest *)requestForMenuWithURL:(NSURL *)menuURL {
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                        URL:menuURL
                                 parameters:nil
                               modelFactory:[LUOrderAheadMenuJSONFactory factory]];
}

+ (LUAPIRequest *)requestForPastOrdersForLocationWithID:(NSNumber *)locationID {
  NSArray *types = @[[LUOrderAheadSuggestedOrder stringForOrderType:LUOrderAheadSuggestedOrderTypePast]];
  return [self requestForSuggestedOrdersForLocationWithID:locationID types:types];
}

+ (LUAPIRequest *)requestForSuggestedOrders {
  return [self requestForSuggestedOrdersForLocationWithID:nil types:nil];
}

+ (LUAPIRequest *)requestForSuggestedOrdersForLocationWithID:(NSNumber *)locationID types:(NSArray *)types {
  NSString *path = @"order_ahead/orders/suggested";

  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  if (locationID) {
    [params lu_setSafeValue:locationID forKey:@"location_id"];
  }
  if (types) {
    [params lu_setSafeValue:[types componentsJoinedByString:@","] forKey:@"types"];
  }

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:path
                                 apiVersion:LUAPIVersion15
                                 parameters:params
                               modelFactory:[LUOrderAheadSuggestedOrderJSONFactory factory]];
}

+ (LUAPIRequest *)requestForViewableOrderWithURL:(NSURL *)URL {
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                        URL:URL
                                 parameters:nil
                               modelFactory:[LUOrderAheadViewableOrderJSONFactory factory]
                         retryResponseCodes:@[@202]
                          retryTimeInterval:0.5];
}

+ (LUAPIRequest *)requestToCompleteOrderWithURL:(NSURL *)URL {
  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                        URL:URL
                                 parameters:nil
                               modelFactory:[LUOrderAheadOrderStatusJSONFactory factory]];
}

+ (LUAPIRequest *)requestToStartUpdateOfOrder:(LUOrderAheadOrder *)requestedOrder {
  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"order_ahead/orders"
                                 apiVersion:LUAPIVersion15
                                 parameters:[requestedOrder JSONDictionary]
                               modelFactory:[LUOrderAheadOrderStatusJSONFactory factory]];
}

@end
