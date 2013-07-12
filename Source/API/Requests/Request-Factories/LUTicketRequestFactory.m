#import "LUAPIClient.h"
#import "LUAuthenticatedAPIRequest.h"
#import "LUTicketRequestFactory.h"
#import "NSDictionary+SafetyAdditions.h"

@implementation LUTicketRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestToCreateTicketWithBody:(NSString *)body {
  NSString *path = [NSString stringWithFormat:@"users/%@/tickets", [LUAPIClient sharedClient].currentUserID];

  NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
  [parameters lu_setSafeValue:body forKey:@"body"];

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"POST"
                                                    path:path
                                              apiVersion:LUAPIVersion13
                                              parameters:@{@"ticket" : parameters}
                                            modelFactory:nil];
}

@end
