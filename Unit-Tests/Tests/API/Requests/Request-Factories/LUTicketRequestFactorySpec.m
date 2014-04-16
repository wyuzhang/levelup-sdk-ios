// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUTicketRequestFactory.h"

SPEC_BEGIN(LUTicketRequestFactorySpec)

describe(@"LUTicketRequestFactory", ^{
  __block LUAPIRequest *request;

  describe(@"requestToCreateTicketWithBody:", ^{
    NSString *body = @"ticket body";

    beforeEach(^{
      request = [LUTicketRequestFactory requestToCreateTicketWithBody:body];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'tickets'", ^{
      [[request.path should] equal:@"tickets"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request with parameters for the ticket body", ^{
      [[request.parameters should] equal:@{@"ticket" : @{@"body" : body}}];
    });
  });
});

SPEC_END
