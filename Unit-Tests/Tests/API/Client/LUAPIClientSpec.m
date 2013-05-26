#import "LUAbstractJSONModelFactory.h"
#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUAPIErrorBuilder.h"
#import "LUConstants.h"

SPEC_BEGIN(LUAPIClientSpec)

describe(@"LUAPIClient", ^{
  beforeAll(^{
    [[LSNocilla sharedInstance] start];
  });

  afterAll(^{
    [[LSNocilla sharedInstance] stop];
  });

  afterEach(^{
    [[LSNocilla sharedInstance] clearStubs];
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
        [LUAPIClient setupWithAPIKey:@"anApiKey" developmentMode:YES];
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

  describe(@"setupWithAPIKey:developmentMode:", ^{
    it(@"enables the network activity manager", ^{
      [LUAPIClient setupWithAPIKey:@"anApiKey" developmentMode:YES];
      [[theValue([AFNetworkActivityIndicatorManager sharedManager].enabled) should] beYes];
    });

    it(@"registers for JSON requests", ^{
      [LUAPIClient setupWithAPIKey:@"anApiKey" developmentMode:YES];
      [[[[LUAPIClient sharedClient] valueForKey:@"registeredHTTPOperationClassNames"] should] contain:@"AFJSONRequestOperation"];
    });

    it(@"sets the default Accept header to 'application/json'", ^{
      [LUAPIClient setupWithAPIKey:@"anApiKey" developmentMode:YES];
      [[[[LUAPIClient sharedClient] valueForKey:@"defaultHeaders"][@"Accept"] should] equal:@"application/json"];
    });

    context(@"when developmentMode is YES", ^{
      beforeEach(^{
        [LUAPIClient setupWithAPIKey:@"anApiKey" developmentMode:YES];
      });

      it(@"sets baseURL to the development URL", ^{
        NSURL *expected = [NSURL URLWithString:LevelUpAPIBaseURLDevelopment];
        [[[LUAPIClient sharedClient].baseURL should] equal:expected];
      });
    });

    context(@"when developmentMode is NO", ^{
      beforeEach(^{
        [LUAPIClient setupWithAPIKey:@"anApiKey" developmentMode:NO];
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
      [LUAPIClient setupWithAPIKey:@"test" developmentMode:YES];
      client = [LUAPIClient sharedClient];

      apiRequest = [LUAPIRequest apiRequestWithMethod:@"GET" path:@"test" apiVersion:LUAPIVersion13 parameters:nil modelFactory:nil];
    });

    it(@"creates an AFJSONRequestOperation operation for the request", ^{
      [AFJSONRequestOperation stub:@selector(JSONRequestOperationWithRequest:success:failure:)];
      [[[AFJSONRequestOperation should] receive] JSONRequestOperationWithRequest:apiRequest.urlRequest
                                                                         success:any()
                                                                         failure:any()];
      [client performRequest:apiRequest success:nil failure:nil];
    });

    it(@"enqueues a new request operation for the request and returns it", ^{
      NSOperation *operation = [client performRequest:apiRequest success:nil failure:nil];

      [[[client.operationQueue operations] should] contain:operation];
    });

    context(@"when the request succeeds", ^{
      beforeEach(^{
        stubRequest(@"GET", @"https://api.staging-levelup.com/v13/test?").
        andReturn(200).
        withHeader(@"Content-Type", @"application/json").
        withBody(@"{\"ok\":true}");
      });

      it(@"creates a model object from the JSON and passes it to the success block", ^{
        id deserializedResponse = [KWMock mock];
        apiRequest.modelFactory = [LUAbstractJSONModelFactory mock];
        [[apiRequest.modelFactory stubAndReturn:deserializedResponse] fromJSONObject:@{@"ok" : @YES} httpResponse:any()];

        __block id successResult;
        [client performRequest:apiRequest
                       success:^(id result) {
                         successResult = result;
                       }
                       failure:nil];

        [[successResult shouldEventually] equal:deserializedResponse];
      });
    });

    context(@"when the request fails", ^{
      beforeEach(^{
        stubRequest(@"GET", @"https://api.staging-levelup.com/v13/test?").
        andReturn(500).
        withHeader(@"Content-Type", @"application/json").
        withBody(@"{\"ok\":true}");
      });

      it(@"builds an error and passes it to the failure block", ^{
        NSError *error = [NSError mock];
        [[LUAPIErrorBuilder stubAndReturn:error] error:any() withMessagesFromJSON:@{@"ok" : @NO}];

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
