#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUTicketRequestBuilder.h"

@implementation LUTicketRequestBuilder

#pragma mark - Public Methods

+ (LUAPIRequest *)requestToCreateTicketWithBody:(NSString *)body {
  NSString *path = [NSString stringWithFormat:@"users/%@/tickets", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest apiRequestWithMethod:@"POST" path:path parameters:@{@"ticket" : @{@"body" : body}}];
}

@end
