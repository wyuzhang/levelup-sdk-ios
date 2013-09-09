// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUAuthenticatedAPIRequest.h"
#import "LUOrderRequestFactory.h"

SPEC_BEGIN(LUOrderRequestFactorySpec)

describe(@"LUOrderRequestFactory", ^{
  // Public Methods

  __block LUAPIRequest *request;

  describe(@"requestForOrders", ^{
    beforeEach(^{
      [LUAPIClient setupWithAppID:@"1" APIKey:@"test" developmentMode:YES];

      request = [LUOrderRequestFactory requestForOrders];
    });

    it(@"returns an authenticated request", ^{
      [[request should] beKindOfClass:[LUAuthenticatedAPIRequest class]];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'apps/:id/orders'", ^{
      [[request.path should] equal:@"apps/1/orders"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });
  });

  describe(@"requestForOrdersOnPage:", ^{
    NSURL *pageURL = [NSURL URLWithString:@"http://example.com/next_page?key=value"];

    beforeEach(^{
      request = [LUOrderRequestFactory requestForOrdersOnPage:pageURL];
    });

    it(@"returns an authenticated request", ^{
      [[request should] beKindOfClass:[LUAuthenticatedAPIRequest class]];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path provided by the page URL", ^{
      [[request.path should] equal:@"next_page?key=value"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });
  });

  describe(@"requestForOrderWithUUID:", ^{
    NSString *UUID = @"dc3ef230f251013007583c075468379e";

    beforeEach(^{
      request = [LUOrderRequestFactory requestForOrderWithUUID:UUID];
    });

    it(@"returns an authenticated request", ^{
      [[request should] beKindOfClass:[LUAuthenticatedAPIRequest class]];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request to the path 'orders/<uuid>'", ^{
      NSString *expectedPath = [NSString stringWithFormat:@"orders/%@", UUID];

      [[request.path should] equal:expectedPath];
    });
  });
});

SPEC_END
