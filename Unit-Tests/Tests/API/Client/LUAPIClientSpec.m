// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAbstractJSONModelFactory.h"
#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUAPIErrorBuilder.h"
#import "LUConstants.h"

SPEC_BEGIN(LUAPIClientSpec)

describe(@"LUAPIClient", ^{
  beforeEach(^{
    [[LUAPIStubbing sharedInstance] disableNetConnect];
  });

  afterEach(^{
    [[LUAPIStubbing sharedInstance] clearStubs];
  });

  // Object Lifecycle Methods

  describe(@"sharedClient", ^{
    context(@"when called before setting up", ^{
      it(@"throws an exception", ^{
        [[theBlock(^{ [LUAPIClient sharedClient]; }) should] raise];
      });
    });

    context(@"after setup", ^{
      beforeEach(^{
        [LUAPIClient setupWithAppID:@"1" APIKey:@"anApiKey" developmentMode:YES];
      });

      it(@"returns an LUAPIClient", ^{
        [[[LUAPIClient sharedClient] should] beKindOfClass:[LUAPIClient class]];
      });

      it(@"returns the same LUAPIClient each time", ^{
        id client1 = [LUAPIClient sharedClient];
        id client2 = [LUAPIClient sharedClient];

        [[client1 should] beIdenticalTo:client2];
      });
    });
  });

  describe(@"setupWithAppID:APIKey:", ^{
    it(@"calls setupWithAppID:APIKey:developmentMode: with developmentMode set to NO", ^{
      [[[LUAPIClient should] receive] setupWithAppID:@"1" APIKey:@"api-key" developmentMode:NO];

      [LUAPIClient setupWithAppID:@"1" APIKey:@"api-key"];
    });
  });

  describe(@"setupWithAppID:APIKey:developmentMode:", ^{
    NSString *appID = @"1";
    NSString *APIKey = @"anAPIKey";
    BOOL developmentMode = NO;

    context(@"with a missing app ID", ^{
      it(@"throws an exception", ^{
        [[theBlock(^{ [LUAPIClient setupWithAppID:nil APIKey:APIKey developmentMode:developmentMode]; }) should] raise];
      });
    });

    context(@"with a missing API key", ^{
      it(@"throws an exception", ^{
        [[theBlock(^{ [LUAPIClient setupWithAppID:appID APIKey:nil developmentMode:developmentMode]; }) should] raise];
      });
    });

    context(@"with an empty API key", ^{
      it(@"throws an exception", ^{
        [[theBlock(^{ [LUAPIClient setupWithAppID:appID APIKey:@"" developmentMode:developmentMode]; }) should] raise];
      });
    });

    context(@"with an app ID and API key", ^{
      beforeEach(^{
        [LUAPIClient setupWithAppID:appID APIKey:APIKey developmentMode:developmentMode];
      });

      it(@"enables the network activity manager", ^{
        [[theValue([AFNetworkActivityIndicatorManager sharedManager].enabled) should] beYes];
      });

      it(@"registers for JSON requests", ^{
        [[[[LUAPIClient sharedClient] valueForKey:@"registeredHTTPOperationClassNames"] should] contain:@"AFJSONRequestOperation"];
      });

      it(@"sets the default Accept header to 'application/json'", ^{
        [[[[LUAPIClient sharedClient] valueForKey:@"defaultHeaders"][@"Accept"] should] equal:@"application/json"];
      });

      it(@"encodes parameters as JSON", ^{
        [[theValue([LUAPIClient sharedClient].parameterEncoding) should] equal:theValue(AFJSONParameterEncoding)];
      });
    });

    context(@"when developmentMode is YES", ^{
      beforeEach(^{
        [LUAPIClient setupWithAppID:appID APIKey:APIKey developmentMode:YES];
      });

      it(@"sets baseURL to the development URL", ^{
        NSURL *expected = [NSURL URLWithString:LevelUpAPIBaseURLDevelopment];
        [[[LUAPIClient sharedClient].baseURL should] equal:expected];
      });
    });

    context(@"when developmentMode is NO", ^{
      beforeEach(^{
        [LUAPIClient setupWithAppID:appID APIKey:APIKey developmentMode:NO];
      });

      it(@"sets baseURL to the production URL", ^{
        NSURL *expected = [NSURL URLWithString:LevelUpAPIBaseURLProduction];
        [[[LUAPIClient sharedClient].baseURL should] equal:expected];
      });
    });
  });

  describe(@"performRequest:success:failure:", ^{
    __block LUAPIRequest *apiRequest;
    __block LUAPIClient *client;

    beforeEach(^{
      [LUAPIClient setupWithAppID:@"1" APIKey:@"test" developmentMode:YES];
      client = [LUAPIClient sharedClient];

      apiRequest = [LUAPIRequest apiRequestWithMethod:@"GET" path:@"test" apiVersion:LUAPIVersion14 parameters:nil modelFactory:nil];
    });

    it(@"creates an AFJSONRequestOperation operation for the request", ^{
      [AFJSONRequestOperation stub:@selector(JSONRequestOperationWithRequest:success:failure:)];
      [[[AFJSONRequestOperation should] receive] JSONRequestOperationWithRequest:[apiRequest URLRequest]
                                                                         success:any()
                                                                         failure:any()];
      [client performRequest:apiRequest success:nil failure:nil];
    });

    it(@"enqueues a new request operation for the request and returns an LUAPIConnection", ^{
      LUAPIConnection *connection = [client performRequest:apiRequest success:nil failure:nil];

      [[[client.operationQueue operations] should] contain:connection.operation];
    });

    context(@"when the request succeeds", ^{
      __block LUAPIStub *stub;
      beforeEach(^{
        stub = [LUAPIStub apiStubForVersion:LUAPIVersion14
                                       path:@"test"
                                 HTTPMethod:@"GET"
                              authenticated:NO
                               responseData:[@"{\"ok\":true}" dataUsingEncoding:NSUTF8StringEncoding]];
        [[LUAPIStubbing sharedInstance] addStub:stub];
      });

      it(@"creates a model object from the JSON and passes it to the success block", ^{
        id deserializedResponse = [KWMock mock];
        apiRequest.modelFactory = [LUAbstractJSONModelFactory mock];
        [apiRequest.modelFactory stub:@selector(fromJSONObject:) andReturn:deserializedResponse withArguments:@{@"ok" : @YES}, nil];

        __block id successResult;
        [client performRequest:apiRequest
                       success:^(id result, LUAPIResponse *response) {
                         successResult = result;
                       }
                       failure:nil];

        [[successResult shouldEventually] equal:deserializedResponse];
      });

      it(@"creates an LUAPIResponse and passes it to the success block", ^{
        __block LUAPIResponse *successResponse;
        [client performRequest:apiRequest
                       success:^(id result, LUAPIResponse *response) {
                         successResponse = response;
                       }
                       failure:nil];

        [[successResponse shouldEventually] beNonNil];
        [[successResponse.HTTPURLResponse.allHeaderFields shouldEventually] equal:stub.responseHeaders];
      });
    });

    context(@"when the request fails", ^{
      beforeEach(^{
        LUAPIStub *stub = [LUAPIStub apiStubForVersion:LUAPIVersion14
                                                  path:@"test"
                                            HTTPMethod:@"GET"
                                         authenticated:NO
                                          responseData:[@"{\"ok\":true}" dataUsingEncoding:NSUTF8StringEncoding]];
        stub.responseCode = 500;
        [[LUAPIStubbing sharedInstance] addStub:stub];
      });

      it(@"builds an error and passes it to the failure block", ^{
        NSError *error = [NSError mock];
        [LUAPIErrorBuilder stub:@selector(error:withMessagesFromJSON:) andReturn:error withArguments:any(), @{@"ok" : @NO}, nil];

        __block NSError *failureError;
        [client performRequest:apiRequest success:nil failure:^(NSError *error) {
          failureError = error;
        }];

        [[failureError shouldEventually] equal:error];
      });
    });
  });
});

SPEC_END
