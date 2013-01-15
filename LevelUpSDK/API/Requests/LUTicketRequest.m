#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUParameterSerializer.h"
#import "LUTicket.h"
#import "LUTicketRequest.h"

@implementation LUTicketRequest

#pragma mark -
#pragma mark Public Methods

+ (LUAPIRequest *)createTicket:(LUTicket *)ticket {
  NSString *path = [NSString stringWithFormat:@"users/%@/tickets", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest apiRequestWithMethod:@"POST" path:path parameters:@{@"ticket" : @{@"body" : ticket.body}}];
}

@end
