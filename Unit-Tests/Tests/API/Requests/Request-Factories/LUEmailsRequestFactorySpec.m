#import "LUAuthenticatedAPIRequest.h"
#import "LUEmailsRequestFactory.h"

SPEC_BEGIN(LUEmailsRequestFactorySpec)

describe(@"LUEmailsRequestFactory", ^{
  __block LUAPIRequest *request;

  describe(@"requestToSendEmailWithID:", ^{
    beforeEach(^{
      request = [LUEmailsRequestFactory requestToSendEmailWithID:@1];
    });

    it(@"returns an authenticated request", ^{
      [[request should] beKindOfClass:[LUAuthenticatedAPIRequest class]];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'emails/:id/send", ^{
      [[request.path should] equal:@"emails/1/send"];
    });

    it(@"returns a request to version 13 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion13];
    });
  });
});

SPEC_END
