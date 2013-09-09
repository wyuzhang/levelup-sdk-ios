// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAuthenticatedAPIRequest.h"
#import "LULocationRequestFactory.h"
#import "LULocationSummaryJSONFactory.h"
#import "LULocationJSONFactory.h"

SPEC_BEGIN(LULocationRequestFactorySpec)

describe(@"LULocationRequestFactory", ^{
  __block LUAPIRequest *request;

  describe(@"requestForAppLocationsNearLocation:", ^{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:41.0 longitude:-71.0];

    beforeEach(^{
      [LUAPIClient setupWithAppID:@"1" APIKey:@"test" developmentMode:YES];
      request = [LULocationRequestFactory requestForAppLocationsNearLocation:location];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'apps/:id/locations", ^{
      [[request.path should] equal:@"apps/1/locations"];
    });

    it(@"returns a request to version v14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request set up to pass the response to an instance of LULocationJSONFactory", ^{
      [[request.modelFactory should] beKindOfClass:[LULocationJSONFactory class]];
    });

    it(@"returns a request with the parameters for the given location", ^{
      NSDictionary *expectedParams = @{@"lat" : @(location.coordinate.latitude), @"lng" : @(location.coordinate.longitude)};

      [[request.parameters should] equal:expectedParams];
    });
  });

  describe(@"requestForAppLocationsOnPage:", ^{
    NSURL *pageURL = [NSURL URLWithString:@"http://example.com/next_page?key=value"];

    beforeEach(^{
      request = [LULocationRequestFactory requestForAppLocationsOnPage:pageURL];
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

    it(@"returns a request set up to pass the response to an instance of LULocationJSONFactory", ^{
      [[request.modelFactory should] beKindOfClass:[LULocationJSONFactory class]];
    });
  });

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

    it(@"returns a request set up to pass the response to an instance of LULocationSummaryJSONFactory", ^{
      [[request.modelFactory should] beKindOfClass:[LULocationSummaryJSONFactory class]];
    });
  });

  describe(@"requestForLocationSummariesOnPage:", ^{
    NSURL *pageURL = [NSURL URLWithString:@"http://example.com/next_page?key=value"];

    beforeEach(^{
      request = [LULocationRequestFactory requestForLocationSummariesOnPage:pageURL];
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

    it(@"returns a request set up to pass the response to an instance of LULocationSummaryJSONFactory", ^{
      [[request.modelFactory should] beKindOfClass:[LULocationSummaryJSONFactory class]];
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
