/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
