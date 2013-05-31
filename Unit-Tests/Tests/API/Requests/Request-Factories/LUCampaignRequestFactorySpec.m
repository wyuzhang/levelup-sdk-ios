#import "LUAuthenticatedAPIRequest.h"
#import "LUCampaignRequestFactory.h"

SPEC_BEGIN(LUCampaignRequestFactorySpec)

describe(@"LUCampaignRequestFactory", ^{
  // Public Methods

  describe(@"requestForCampaignWithID:", ^{
    __block LUAPIRequest *request;

    beforeEach(^{
      request = [LUCampaignRequestFactory requestForCampaignWithID:@1];
    });

    it(@"returns an authenticated request", ^{
      [[request should] beKindOfClass:[LUAuthenticatedAPIRequest class]];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'campaigns/<id>'", ^{
      [[request.path should] equal:@"campaigns/1"];
    });

    it(@"returns a request to version 13 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion13];
    });

    it(@"returns a request with no parameters", ^{
      [[request.parameters should] beEmpty];
    });
  });
});

SPEC_END
