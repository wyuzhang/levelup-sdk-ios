#import "LUAuthenticatedAPIRequest.h"
#import "LUCampaignRequestFactory.h"

SPEC_BEGIN(LUCampaignRequestFactorySpec)

describe(@"LUCampaignRequestFactory", ^{
  // Public Methods

  describe(@"requestForMerchantsForCampaignWithID:", ^{
    __block LUAPIRequest *request;

    beforeEach(^{
      request = [LUCampaignRequestFactory requestForMerchantsForCampaignWithID:@1];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'campaigns/<id>/merchants'", ^{
      [[request.path should] equal:@"campaigns/1/merchants"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request with no parameters", ^{
      [request.parameters shouldBeNil];
    });
  });

  describe(@"requestForCampaignWithCode:", ^{
    __block LUAPIRequest *request;
    NSString *code = @"code";

    beforeEach(^{
      request = [LUCampaignRequestFactory requestForCampaignWithCode:code];
    });

    it(@"returns an authenticated request", ^{
      [[request should] beKindOfClass:[LUAuthenticatedAPIRequest class]];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'codes/<code>/campaign'", ^{
      NSString *expectedPath = [NSString stringWithFormat:@"codes/%@/campaign", code];

      [[request.path should] equal:expectedPath];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request with no parameters", ^{
      [request.parameters shouldBeNil];
    });
  });

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

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request with no parameters", ^{
      [request.parameters shouldBeNil];
    });
  });
});

SPEC_END
