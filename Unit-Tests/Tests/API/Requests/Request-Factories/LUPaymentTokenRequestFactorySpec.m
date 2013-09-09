// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAuthenticatedAPIRequest.h"
#import "LUPaymentTokenRequestFactory.h"

SPEC_BEGIN(LUPaymentTokenRequestFactorySpec)

describe(@"LUPaymentTokenRequestFactory", ^{
  // Public Methods

  __block LUAPIRequest *request;

  describe(@"requestForPaymentToken", ^{
    beforeEach(^{
      request = [LUPaymentTokenRequestFactory requestForPaymentToken];
    });

    it(@"returns an authenticated request", ^{
      [[request should] beKindOfClass:[LUAuthenticatedAPIRequest class]];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'payment_token'", ^{
      [[request.path should] equal:@"payment_token"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request with no parameters", ^{
      [request.parameters shouldBeNil];
    });
  });
});

SPEC_END
