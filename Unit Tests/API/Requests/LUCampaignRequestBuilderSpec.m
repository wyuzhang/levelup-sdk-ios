#import "LUAPIRequest.h"
#import "LUCampaignRequestBuilder.h"

SPEC_BEGIN(LUCampaignRequestBuilderSpec)

describe(@"LUCampaignRequestBuilder", ^{
  // Public Methods

  describe(@"requestForCampaignWithId:", ^{
    __block LUAPIRequest *request;

    beforeEach(^{
      request = [LUCampaignRequestBuilder requestForCampaignWithId:@1];
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
