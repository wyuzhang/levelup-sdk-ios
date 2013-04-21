#import "LUAPIClient.h"
#import "LUAuthenticatedAPIRequest.h"
#import "LUTicketRequestFactory.h"

@implementation LUTicketRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestToCreateTicketWithBody:(NSString *)body {
  NSString *path = [NSString stringWithFormat:@"users/%@/tickets", [LUAPIClient sharedClient].currentUserID];

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"POST"
                                                    path:path
                                              parameters:@{@"ticket" : @{@"body" : body}}
                                            modelFactory:nil];
}

@end
