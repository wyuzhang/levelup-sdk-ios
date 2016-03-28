/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
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

#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LULocationRequestFactory.h"
#import "LULocationSummaryJSONFactory.h"
#import "LULocationJSONFactory.h"
#import "LUWebLinkJSONFactory.h"
#import "NSDictionary+SafetyAdditions.h"
#import "NSURL+LUAdditions.h"

@implementation LULocationRequestFactory

+ (LUAPIRequest *)requestForAppLocationsNearLocation:(CLLocation *)location {
  NSString *requestPath = [NSString stringWithFormat:@"apps/%@/locations", [LUAPIClient sharedClient].appID];

  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  if (location) {
    [params lu_setSafeValue:@(location.coordinate.latitude) forKey:@"lat"];
    [params lu_setSafeValue:@(location.coordinate.longitude) forKey:@"lng"];
  }

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:requestPath
                                 apiVersion:LUAPIVersion14
                                 parameters:params
                               modelFactory:[LULocationJSONFactory factory]];
}

+ (LUAPIRequest *)requestForAppPickupLocationsNear:(CLLocation *)location {
  return [self apiRequestWithPickupFulfillmentTypeAdded:[self requestForAppLocationsNearLocation:location]];
}

+ (LUAPIRequest *)requestForAppLocationsOnPage:(NSURL *)pageURL {
  if (!pageURL) return [self requestForLocationSummaries];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:[pageURL lu_pathAndQueryWithoutAPIVersion]
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LULocationJSONFactory factory]];
}

+ (LUAPIRequest *)requestForLocationSummaries {
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:@"locations"
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LULocationSummaryJSONFactory factory]];
}

+ (LUAPIRequest *)requestForLocationSummariesOnPage:(NSURL *)pageURL {
  if (!pageURL) return [self requestForLocationSummaries];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:[pageURL lu_pathAndQueryWithoutAPIVersion]
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LULocationSummaryJSONFactory factory]];
}

+ (LUAPIRequest *)requestForLocationWithID:(NSNumber *)locationID {
  NSString *requestPath = [@"locations/" stringByAppendingString:[locationID stringValue]];
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:requestPath
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LULocationJSONFactory factory]];
}

+ (LUAPIRequest *)requestForMerchantLocationsNearLocation:(CLLocation *)location forMerchantID:(NSNumber *)merchantID {
  NSString *requestPath = [NSString stringWithFormat:@"merchants/%@/locations", merchantID];

  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  if (location) {
    [params lu_setSafeValue:@(location.coordinate.latitude) forKey:@"lat"];
    [params lu_setSafeValue:@(location.coordinate.longitude) forKey:@"lng"];
  }

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:requestPath
                                 apiVersion:LUAPIVersion15
                                 parameters:params
                               modelFactory:[LULocationJSONFactory factory]];
}

+ (LUAPIRequest *)requestForMerchantLocationsOnPage:(NSURL *)pageURL {
  NSAssert(pageURL != nil, @"A non-nil pageURL is required.");

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:[pageURL lu_pathAndQueryWithoutAPIVersion]
                                 apiVersion:LUAPIVersion15
                                 parameters:nil
                               modelFactory:[LULocationJSONFactory factory]];
}


+ (LUAPIRequest *)requestForPickupLocationsNear:(CLLocation *)location forMerchantID:(NSNumber *)merchantID {
  return [self apiRequestWithPickupFulfillmentTypeAdded:[self requestForMerchantLocationsNearLocation:location
                                                                                        forMerchantID:merchantID]];
}

+ (LUAPIRequest *)requestForWebLinksAtLocationWithID:(NSNumber *)locationID {
  NSString *requestPath = [NSString stringWithFormat:@"locations/%@/web_links", [locationID stringValue]];
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:requestPath
                                 apiVersion:LUAPIVersion15
                                 parameters:nil
                               modelFactory:[LUWebLinkJSONFactory factory]];
}

#pragma mark - Private Methods

+ (LUAPIRequest *)apiRequestWithPickupFulfillmentTypeAdded:(LUAPIRequest *)request {
  NSMutableDictionary *params = [request.parameters mutableCopy];
  params[@"fulfillment_types"] = @"pickup";
  request.parameters = [NSDictionary dictionaryWithDictionary:params];

  return request;
}

@end
