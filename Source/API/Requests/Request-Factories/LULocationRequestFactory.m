#import "LUAPIRequest.h"
#import "LULocationRequestFactory.h"
#import "LULocationSummaryJSONFactory.h"

@implementation LULocationRequestFactory

+ (LUAPIRequest *)requestForLocationSummaries {
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:@"locations"
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LULocationSummaryJSONFactory factory]];
}

+ (LUAPIRequest *)requestForLocationSummaryPage:(NSURL *)pageURL {
  if (!pageURL) return [self requestForLocationSummaries];

  NSString *pathWithQuery = [NSString stringWithFormat:@"%@?%@", [pageURL lastPathComponent], [pageURL query]];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:pathWithQuery
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LULocationSummaryJSONFactory factory]];
}

@end
