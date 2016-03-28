/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "LUAPIRequest.h"
#import "LULocationRequestFactory.h"
#import "LULocationSummaryJSONFactory.h"
#import "LULocationJSONFactory.h"

SPEC_BEGIN(LULocationRequestFactorySpec)

describe(@"LULocationRequestFactory", ^{
  CLLocation *location = [[CLLocation alloc] initWithLatitude:41.0 longitude:-71.0];
  __block LUAPIRequest *request;

  describe(@"requestForAppLocationsNearLocation:", ^{
    beforeEach(^{
      [LUAPIClient setupWithAppID:@"1" APIKey:@"test"];
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

    context(@"when a location is not provided", ^{
      beforeEach(^{
        request = [LULocationRequestFactory requestForAppLocationsNearLocation:nil];
      });

      it(@"returns a request without any parameters", ^{
        [[request.parameters should] beEmpty];
      });
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

  describe(@"requestForAppPickupLocationsNear:", ^{
    beforeEach(^{
      request = [LULocationRequestFactory requestForAppPickupLocationsNear:location];
    });

    it(@"returns a request for pickup app locations near the given location", ^{
      LUAPIRequest *appLocationsRequest = [LULocationRequestFactory requestForAppPickupLocationsNear:location];

      [[request.path should] equal:appLocationsRequest.path];
    });

    it(@"requests locations with fulfillment type 'pickup'", ^{
      [[request.parameters[@"fulfillment_types"] should] equal:@"pickup"];
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

  describe(@"requestForMerchantLocationsNearLocation:forMerchantID:", ^{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:41.0 longitude:-71.0];

    beforeEach(^{
      [LUAPIClient setupWithAppID:@"1" APIKey:@"test"];
      request = [LULocationRequestFactory requestForMerchantLocationsNearLocation:location forMerchantID:@1];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'merchants/:id/locations", ^{
      [[request.path should] equal:@"merchants/1/locations"];
    });

    it(@"returns a request to version v15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    it(@"returns a request set up to pass the response to an instance of LULocationJSONFactory", ^{
      [[request.modelFactory should] beKindOfClass:[LULocationJSONFactory class]];
    });

    it(@"returns a request with the parameters for the given location", ^{
      NSDictionary *expectedParams = @{@"lat" : @(location.coordinate.latitude), @"lng" : @(location.coordinate.longitude)};

      [[request.parameters should] equal:expectedParams];
    });

    context(@"when a location is not provided", ^{
      beforeEach(^{
        request = [LULocationRequestFactory requestForMerchantLocationsNearLocation:nil forMerchantID:@1];
      });

      it(@"returns a request without any parameters", ^{
        [[request.parameters should] beEmpty];
      });
    });
  });

  describe(@"requestForMerchantLocationsOnPage:", ^{
    NSURL *pageURL = [NSURL URLWithString:@"http://example.com/next_page?key=value"];

    beforeEach(^{
      request = [LULocationRequestFactory requestForMerchantLocationsOnPage:pageURL];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path provided by the page URL", ^{
      [[request.path should] equal:@"next_page?key=value"];
    });

    it(@"returns a request to version v15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    it(@"returns a request set up to pass the response to an instance of LULocationJSONFactory", ^{
      [[request.modelFactory should] beKindOfClass:[LULocationJSONFactory class]];
    });
  });

  describe(@"requestForPickupLocationsNear:forMerchantID:", ^{
    NSNumber *merchantID = @1;

    beforeEach(^{
      request = [LULocationRequestFactory requestForPickupLocationsNear:location forMerchantID:merchantID];
    });

    it(@"returns a request for pickup merchant locations near the given location", ^{
      LUAPIRequest *merchantLocationsRequest =
        [LULocationRequestFactory requestForMerchantLocationsNearLocation:location forMerchantID:merchantID];

      [[request.path should] equal:merchantLocationsRequest.path];
    });

    it(@"requests locations with fulfillment type 'pickup'", ^{
      [[request.parameters[@"fulfillment_types"] should] equal:@"pickup"];
    });
  });
});

SPEC_END
