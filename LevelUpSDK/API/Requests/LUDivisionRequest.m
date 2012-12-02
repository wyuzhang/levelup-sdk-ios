#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUDivisionRequest.h"

@implementation LUDivisionRequest

+ (LUAPIRequest *)getDivisions {
  return [LUAPIRequest apiRequestWithMethod:@"GET" path:@"divisions" parameters:nil];
}

@end
