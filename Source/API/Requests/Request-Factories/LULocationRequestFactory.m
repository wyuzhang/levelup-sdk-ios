// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LULocationRequestFactory.h"
#import "LULocationSummaryJSONFactory.h"
#import "LULocationJSONFactory.h"
#import "NSURL+LUAdditions.h"

@implementation LULocationRequestFactory

+ (LUAPIRequest *)requestForAppLocationsNearLocation:(CLLocation *)location {
  NSString *requestPath = [NSString stringWithFormat:@"apps/%@/locations", [LUAPIClient sharedClient].appID];
  NSDictionary *params = @{@"lat" : @(location.coordinate.latitude), @"lng" : @(location.coordinate.longitude)};

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:requestPath
                                 apiVersion:LUAPIVersion14
                                 parameters:params
                               modelFactory:[LULocationJSONFactory factory]];
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

@end
