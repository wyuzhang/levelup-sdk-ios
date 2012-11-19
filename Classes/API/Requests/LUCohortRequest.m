#import <Foundation/Foundation.h>
#import "LUAPIRequest.h"
#import "LUCohortRequest.h"

@implementation LUCohortRequest

+ (LUAPIRequest *)getCohortWithCode:(NSString *)code {
  NSString *path = [NSString stringWithFormat:@"cohorts/%@", code];

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:path parameters:nil];

}

@end
