#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUBundleRequestFactory.h"

SPEC_BEGIN(LUBundleRequestFactorySpec)

describe(@"LUBundleRequestFactory", ^{
  // Public Methods

  describe(@"requestForBundlesOnPage:", ^{
    __block LUAPIRequest *request;

    beforeEach(^{
      [[LUAPIClient sharedClient] stub:@selector(currentUserID) andReturn:@1];

      request = [LUBundleRequestFactory requestForBundlesOnPage:1];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'users/<userid>/bundles'", ^{
      [[request.path should] equal:@"users/1/bundles"];
    });

    it(@"returns a request to version 13 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion13];
    });

    it(@"returns a request with parameters for the given page", ^{
      NSDictionary *expectedParams = @{@"page" : @1};

      [[request.parameters should] equal:expectedParams];
    });
  });
});

SPEC_END
