#import "LULocationRequestFactory.h"
#import "LULocationJSONFactory.h"

SPEC_BEGIN(LULocationRequestFactorySpec)

describe(@"LULocationRequestFactory", ^{
  __block LUAPIRequest *request;

  describe(@"requestForLocationSummaries", ^{
    beforeEach(^{
      request = [LULocationRequestFactory requestForLocationSummaries];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'locations'", ^{
      [[request.path should] equal:@"locations"];
    });

    it(@"returns a request to version v14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });
  });

  describe(@"requestForLocationSummaryPage:", ^{
    NSURL *pageURL = [NSURL URLWithString:@"http://example.com/next_page?key=value"];

    beforeEach(^{
      request = [LULocationRequestFactory requestForLocationSummaryPage:pageURL];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path provided by the page URL", ^{
      [[request.path should] equal:@"next_page?key=value"];
    });

    it(@"returns a request to version v14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });
  });

  describe(@"requestForLocationWithID:", ^{
    beforeEach(^{
      request = [LULocationRequestFactory requestForLocationWithID:@1];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path for the location", ^{
      [[request.path should] equal:@"locations/1"];
    });

    it(@"returns a request to version v14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request set up to pass the response to an instance of LULocationJSONFactory", ^{
      [[request.modelFactory should] beKindOfClass:[LULocationJSONFactory class]];
    });
  });
});

SPEC_END
