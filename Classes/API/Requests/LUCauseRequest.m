#import <CoreLocation/CoreLocation.h>
#import "LUAPIRequest.h"
#import "LUCauseCategory.h"
#import "LUCauseRequest.h"

@implementation LUCauseRequest

+ (LUAPIRequest *)getCausesInCategory:(LUCauseCategory *)causeCategory page:(NSUInteger)page {
  return [self getCausesWithParameters:@{@"category_ids" : causeCategory.modelId, @"page" : @(page)}];
}

+ (LUAPIRequest *)getCausesNearLocation:(CLLocation *)location page:(NSUInteger)page {
  return [self getCausesWithParameters:@{@"lat" : @(location.coordinate.latitude), @"lng" : @(location.coordinate.longitude), @"page" : @(page)}];
}

+ (LUAPIRequest *)getCausesOnPage:(NSUInteger)page {
  return [self getCausesWithParameters:@{@"page" : @(page)}];
}

+ (LUAPIRequest *)getFeaturedCauses {
  return [self getCausesWithParameters:@{@"featured" : @1}];
}

#pragma mark -
#pragma mark Private Methods

+ (LUAPIRequest *)getCausesWithParameters:(NSDictionary *)parameters {
  return [LUAPIRequest apiRequestWithMethod:@"GET" path:@"causes" parameters:parameters];
}

@end
