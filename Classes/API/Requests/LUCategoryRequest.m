#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUCategoryRequest.h"

@implementation LUCategoryRequest

+ (LUAPIRequest *)getCauseCategories {
  return [LUAPIRequest apiRequestWithMethod:@"GET" path:@"cause_categories" parameters:nil];
}

+ (LUAPIRequest *)getCategories {
  return [LUAPIRequest apiRequestWithMethod:@"GET" path:@"categories" parameters:nil];
}

@end
