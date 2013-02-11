#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUBundleRequestBuilder.h"

SPEC_BEGIN(LUBundleRequestBuilderSpec)

describe(@"LUBundleRequestBuilder", ^{
  // Public Methods

  describe(@"requestForBundlesOnPage:", ^{
    __block LUAPIRequest *request;

    beforeEach(^{
      [[LUAPIClient sharedClient] stub:@selector(currentUserId) andReturn:@1];

      request = [LUBundleRequestBuilder requestForBundlesOnPage:1];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'users/<userid>/bundles'", ^{
      [[request.path should] equal:@"users/1/bundles"];
    });

    it(@"returns a request with parameters for the given page", ^{
      NSDictionary *expectedParams = @{@"page" : @1};

      [[request.parameters should] equal:expectedParams];
    });
  });
});

SPEC_END
