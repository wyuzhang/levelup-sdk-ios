#import "LUAPIRequest.h"
#import "LUCampaignRequestFactory.h"

SPEC_BEGIN(LUCampaignRequestFactorySpec)

describe(@"LUCampaignRequestFactory", ^{
  // Public Methods

  describe(@"requestForCampaignWithId:", ^{
    __block LUAPIRequest *request;

    beforeEach(^{
      request = [LUCampaignRequestFactory requestForCampaignWithId:@1];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'campaigns/<id>'", ^{
      [[request.path should] equal:@"campaigns/1"];
    });

    it(@"returns a request with no parameters", ^{
      [request.parameters shouldBeNil];
    });
  });
});

SPEC_END
