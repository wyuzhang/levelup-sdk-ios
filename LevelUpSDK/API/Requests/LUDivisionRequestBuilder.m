#import "LUAPIRequest.h"
#import "LUDivisionRequestBuilder.h"

@implementation LUDivisionRequestBuilder

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForAllDivisions {
  return [LUAPIRequest apiRequestWithMethod:@"GET" path:@"divisions" parameters:nil];
}

@end
