#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUTicketRequestFactory.h"

SPEC_BEGIN(LUTicketRequestFactorySpec)

describe(@"LUTicketRequestFactory", ^{
  __block LUAPIRequest *request;

  describe(@"requestToCreateTicketWithBody:", ^{
    NSString *body = @"ticket body";

    beforeEach(^{
      [[LUAPIClient sharedClient] stub:@selector(currentUserID) andReturn:@1];

      request = [LUTicketRequestFactory requestToCreateTicketWithBody:body];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'users/<userid>/tickets'", ^{
      [[request.path should] equal:@"users/1/tickets"];
    });

    it(@"returns a request to version 13 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion13];
    });

    it(@"returns a request with parameters for the ticket body", ^{
      [[request.parameters should] equal:@{@"ticket" : @{@"body" : body}}];
    });
  });
});

SPEC_END
