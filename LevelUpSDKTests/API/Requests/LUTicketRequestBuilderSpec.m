#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUTicketRequestBuilder.h"

SPEC_BEGIN(LUTicketRequestBuilderSpec)

describe(@"LUTicketRequestBuilder", ^{
  __block LUAPIRequest *request;

  describe(@"requestToCreateTicketWithBody:", ^{
    NSString *body = @"ticket body";

    beforeEach(^{
      [[LUAPIClient sharedClient] stub:@selector(currentUserId) andReturn:@1];

      request = [LUTicketRequestBuilder requestToCreateTicketWithBody:body];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'users/<userid>/tickets'", ^{
      [[request.path should] equal:@"users/1/tickets"];
    });

    it(@"returns a request with parameters for the ticket body", ^{
      [[request.parameters should] equal:@{@"ticket" : @{@"body" : body}}];
    });
  });
});

SPEC_END
