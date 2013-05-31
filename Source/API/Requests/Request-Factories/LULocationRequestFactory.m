#import "LUAPIRequest.h"
#import "LUAuthenticatedAPIRequest.h"
#import "LULocationJSONFactory.h"
#import "LULocationRequestFactory.h"
#import "LULocationSummaryJSONFactory.h"
#import "LULocationV14JSONFactory.h"

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

+ (LUAPIRequest *)requestForLocationsWithMerchantID:(NSNumber *)merchantID {
  NSString *requestPath = [NSString stringWithFormat:@"merchants/%@/locations", [merchantID stringValue]];
  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"GET"
                                                    path:requestPath
                                              apiVersion:LUAPIVersion13
                                              parameters:nil
                                            modelFactory:[LULocationJSONFactory factory]];
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
