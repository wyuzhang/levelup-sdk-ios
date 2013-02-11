#import <CoreLocation/CoreLocation.h>
#import "LUAPIRequest.h"
#import "LUCauseCategory.h"
#import "LUCauseRequestBuilder.h"

@implementation LUCauseRequestBuilder

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForAllFeaturedCauses {
  return [self requestForCausesWithParameters:@{@"featured" : @YES}];
}

+ (LUAPIRequest *)requestForCausesInCategory:(LUCauseCategory *)causeCategory page:(NSUInteger)page {
  return [self requestForCausesWithParameters:@{@"category_ids" : causeCategory.modelId, @"page" : @(page)}];
}

+ (LUAPIRequest *)requestForCausesNearLocation:(CLLocation *)location page:(NSUInteger)page {
  return [self requestForCausesWithParameters:@{@"lat" : @(location.coordinate.latitude), @"lng" : @(location.coordinate.longitude), @"page" : @(page)}];
}

+ (LUAPIRequest *)requestForCausesOnPage:(NSUInteger)page {
  return [self requestForCausesWithParameters:@{@"page" : @(page)}];
}

#pragma mark - Private Methods

+ (LUAPIRequest *)requestForCausesWithParameters:(NSDictionary *)parameters {
  return [LUAPIRequest apiRequestWithMethod:@"GET" path:@"causes" parameters:parameters];
}

@end
