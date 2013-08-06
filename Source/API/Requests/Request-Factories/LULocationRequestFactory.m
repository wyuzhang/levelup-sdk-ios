#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LULocationRequestFactory.h"
#import "LULocationSummaryJSONFactory.h"
#import "LULocationV14JSONFactory.h"

@implementation LULocationRequestFactory

+ (LUAPIRequest *)requestForAppLocationsNearLocation:(CLLocation *)location {
  NSString *requestPath = [NSString stringWithFormat:@"apps/%@/locations", [LUAPIClient sharedClient].appID];
  NSDictionary *params = @{@"lat" : @(location.coordinate.latitude), @"lng" : @(location.coordinate.longitude)};

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:requestPath
                                 apiVersion:LUAPIVersion14
                                 parameters:params
                               modelFactory:[LULocationV14JSONFactory factory]];
}

+ (LUAPIRequest *)requestForAppLocationsOnPage:(NSURL *)pageURL {
  if (!pageURL) return [self requestForLocationSummaries];

  NSString *pathWithQuery = [NSString stringWithFormat:@"%@?%@", [pageURL lastPathComponent], [pageURL query]];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:pathWithQuery
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LULocationV14JSONFactory factory]];
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

  NSString *pathWithQuery = [NSString stringWithFormat:@"%@?%@", [pageURL lastPathComponent], [pageURL query]];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:pathWithQuery
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
                               modelFactory:[LULocationV14JSONFactory factory]];
}

@end
