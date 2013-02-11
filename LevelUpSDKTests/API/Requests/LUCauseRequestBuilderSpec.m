#import <CoreLocation/CoreLocation.h>
#import "LUAPIRequest.h"
#import "LUCauseCategory.h"
#import "LUCauseRequestBuilder.h"

SPEC_BEGIN(LUCauseRequestBuilderSpec)

describe(@"LUCauseRequestBuilder", ^{
  // Public Methods

  __block LUAPIRequest *request;

  describe(@"requestForAllFeaturedCauses", ^{
    beforeEach(^{
      request = [LUCauseRequestBuilder requestForAllFeaturedCauses];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'causes'", ^{
      [[request.path should] equal:@"causes"];
    });

    it(@"returns a request with parameters for featured causes", ^{
      [[request.parameters should] equal:@{@"featured": @YES}];
    });
  });

  describe(@"requestForCausesInCategory:page:", ^{
    LUCauseCategory *causeCategory = [[LUCauseCategory alloc] init];
    causeCategory.modelId = @1;

    NSUInteger page = 2;

    beforeEach(^{
      request = [LUCauseRequestBuilder requestForCausesInCategory:causeCategory page:page];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'causes'", ^{
      [[request.path should] equal:@"causes"];
    });

    it(@"returns a request with the parameters for the given category and page", ^{
      NSDictionary *expectedParams = @{@"category_ids" : causeCategory.modelId, @"page" : @(page)};

      [[request.parameters should] equal:expectedParams];
    });
  });

  describe(@"requestForCausesNearLocation:page:", ^{
    CLLocationDegrees lat = 45, lng = -45;
    NSUInteger page = 3;

    beforeEach(^{
      CLLocation *location = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
      request = [LUCauseRequestBuilder requestForCausesNearLocation:location page:page];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'causes'", ^{
      [[request.path should] equal:@"causes"];
    });

    it(@"returns a request with the parameters for the given location and page", ^{
      NSDictionary *expectedParams = @{@"lat" : @(lat), @"lng" : @(lng), @"page" : @(page)};

      [[request.parameters should] equal:expectedParams];
    });
  });

  describe(@"requestForCausesOnPage:", ^{
    NSUInteger page = 4;

    beforeEach(^{
      request = [LUCauseRequestBuilder requestForCausesOnPage:page];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'causes'", ^{
      [[request.path should] equal:@"causes"];
    });

    it(@"returns a request with the parameters for the given page", ^{
      [[request.parameters should] equal:@{@"page": @(page)}];
    });
  });
});

SPEC_END
