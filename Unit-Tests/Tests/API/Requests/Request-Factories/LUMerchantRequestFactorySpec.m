#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUCategory.h"
#import "LUMerchantRequestFactory.h"

SPEC_BEGIN(LUMerchantRequestFactorySpec)

describe(@"LUMerchantRequestFactory", ^{
  // Public Methods

  __block LUAPIRequest *request;

  describe(@"requestForUserMerchantsOnPage:", ^{
    NSUInteger page = 2;

    beforeEach(^{
      [[LUAPIClient sharedClient] stub:@selector(currentUserID) andReturn:@1];

      request = [LUMerchantRequestFactory requestForUserMerchantsOnPage:page];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'users/<userid>/merchants'", ^{
      [[request.path should] equal:@"users/1/merchants"];
    });

    it(@"returns a request to version 13 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion13];
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
      request = [LUMerchantRequestFactory requestForMerchantsNearLocation:location page:page];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'merchants'", ^{
      [[request.path should] equal:@"merchants"];
    });

    it(@"returns a request to version 13 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion13];
    });

    it(@"returns a request with the parameters for the given location and page", ^{
      NSDictionary *expectedParams = @{@"lat" : @(lat), @"lng" : @(lng), @"page" : @(page)};

      [[request.parameters should] equal:expectedParams];
    });
  });

  describe(@"requestForMerchantsNearLocation:inCategory:page:", ^{
    CLLocationDegrees lat = 45, lng = -45;
    LUCategory *category = [[LUCategory alloc] initWithCategoryID:@3 name:nil];
    NSUInteger page = 4;

    beforeEach(^{
      CLLocation *location = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
      request = [LUMerchantRequestFactory requestForMerchantsNearLocation:location inCategory:category page:page];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'merchants'", ^{
      [[request.path should] equal:@"merchants"];
    });

    it(@"returns a request to version 13 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion13];
    });

    it(@"returns a request with the parameters for the given location, category and page", ^{
      NSDictionary *expectedParams = @{
        @"lat" : @(lat),
        @"lng" : @(lng),
        @"category_ids" : category.categoryID,
        @"page" : @(page)
      };

      [[request.parameters should] equal:expectedParams];
    });
  });

  describe(@"requestForMerchantWithId:", ^{
    beforeEach(^{
      request = [LUMerchantRequestFactory requestForMerchantWithId:@1];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'merchants/<id>'", ^{
      [[request.path should] equal:@"merchants/1"];
    });

    it(@"returns a request to version 13 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion13];
    });

    it(@"returns a request with no parameters", ^{
      [request.parameters shouldBeNil];
    });
  });
});

SPEC_END
