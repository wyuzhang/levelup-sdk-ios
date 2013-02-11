#import "LUAPIRequest.h"
#import "LUCategoryRequestBuilder.h"

@implementation LUCategoryRequestBuilder

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForAllCategories {
  return [LUAPIRequest apiRequestWithMethod:@"GET" path:@"categories" parameters:nil];
}

+ (LUAPIRequest *)requestForAllCauseCategories {
  return [LUAPIRequest apiRequestWithMethod:@"GET" path:@"cause_categories" parameters:nil];
}

@end
