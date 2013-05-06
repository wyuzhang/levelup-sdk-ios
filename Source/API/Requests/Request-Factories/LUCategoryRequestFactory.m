#import "LUAPIRequest.h"
#import "LUCategoryJSONFactory.h"
#import "LUCategoryRequestFactory.h"

@implementation LUCategoryRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForAllCategories {
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:@"categories"
                                 apiVersion:LUAPIVersion13
                                 parameters:nil
                               modelFactory:[LUCategoryJSONFactory factory]];
}

+ (LUAPIRequest *)requestForAllCauseCategories {
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:@"cause_categories"
                                 apiVersion:LUAPIVersion13
                                 parameters:nil
                               modelFactory:[LUCategoryJSONFactory factory]];
}

@end
