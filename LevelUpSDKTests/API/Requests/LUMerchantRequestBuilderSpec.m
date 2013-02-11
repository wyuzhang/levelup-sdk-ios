#import <CoreLocation/CoreLocation.h>
#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUCategory.h"
#import "LUMerchantRequestBuilder.h"

SPEC_BEGIN(LUMerchantRequestBuilderSpec)

describe(@"LUMerchantRequestBuilder", ^{
  // Public Methods

  __block LUAPIRequest *request;

  describe(@"requestForUserMerchantsOnPage:", ^{
    NSUInteger page = 2;

    beforeEach(^{
      [[LUAPIClient sharedClient] stub:@selector(currentUserId) andReturn:@1];

      request = [LUMerchantRequestBuilder requestForUserMerchantsOnPage:page];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'users/<userid>/merchants'", ^{
      [[request.path should] equal:@"users/1/merchants"];
    });

    it(@"returns a request with parameters for the given page", ^{
      [[request.parameters should] equal:@{@"page" : @(page)}];
    });
  });

  describe(@"requestForMerchantsNearLocation:page:", ^{
    CLLocationDegrees lat = 45, lng = -45;
    NSUInteger page = 3;

    beforeEach(^{
      CLLocation *location = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
      request = [LUMerchantRequestBuilder requestForMerchantsNearLocation:location page:page];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'merchants'", ^{
      [[request.path should] equal:@"merchants"];
    });

    it(@"returns a request with the parameters for the given location and page", ^{
      NSDictionary *expectedParams = @{@"lat" : @(lat), @"lng" : @(lng), @"page" : @(page)};

      [[request.parameters should] equal:expectedParams];
    });
  });

  describe(@"requestForMerchantsNearLocation:inCategory:page:", ^{
    CLLocationDegrees lat = 45, lng = -45;
    LUCategory *category = [[LUCategory alloc] init];
    category.modelId = @3;
    NSUInteger page = 4;

    beforeEach(^{
      CLLocation *location = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
      request = [LUMerchantRequestBuilder requestForMerchantsNearLocation:location inCategory:category page:page];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'merchants'", ^{
      [[request.path should] equal:@"merchants"];
    });

    it(@"returns a request with the parameters for the given location, category and page", ^{
      NSDictionary *expectedParams = @{
        @"lat" : @(lat),
        @"lng" : @(lng),
        @"category_ids" : category.modelId,
        @"page" : @(page)
      };

      [[request.parameters should] equal:expectedParams];
    });
  });

  describe(@"requestForMerchantWithId:", ^{
    beforeEach(^{
      request = [LUMerchantRequestBuilder requestForMerchantWithId:@1];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'merchants/<id>'", ^{
      [[request.path should] equal:@"merchants/1"];
    });

    it(@"returns a request with no parameters", ^{
      [request.parameters shouldBeNil];
    });
  });
});

SPEC_END
