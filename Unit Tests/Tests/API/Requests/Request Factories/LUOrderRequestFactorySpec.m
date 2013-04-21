#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUAuthenticatedAPIRequest.h"
#import "LUOrderRequestFactory.h"

SPEC_BEGIN(LUOrderRequestFactorySpec)

describe(@"LUOrderRequestFactory", ^{
  // Public Methods

  __block LUAPIRequest *request;

  describe(@"requestForOrdersAtMerchantWithId:page:", ^{
    NSNumber *merchantId = @2;
    NSUInteger page = 3;

    beforeEach(^{
      [[LUAPIClient sharedClient] stub:@selector(currentUserID) andReturn:@1];

      request = [LUOrderRequestFactory requestForOrdersAtMerchantWithId:merchantId page:page];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'users/<userid>/orders'", ^{
      [[request.path should] equal:@"users/1/orders"];
    });

    it(@"returns a request with parameters for the given merchant and page", ^{
      [[request.parameters should] equal:@{@"merchant_ids" : merchantId, @"page" : @(page)}];
    });
  });

  describe(@"requestForOrdersOnPage:", ^{
    NSUInteger page = 2;

    beforeEach(^{
      [[LUAPIClient sharedClient] stub:@selector(currentUserID) andReturn:@1];

      request = [LUOrderRequestFactory requestForOrdersOnPage:page];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'users/<userid>/orders'", ^{
      [[request.path should] equal:@"users/1/orders"];
    });

    it(@"returns a request with parameters for the given page", ^{
      [[request.parameters should] equal:@{@"page" : @(page)}];
    });
  });

  describe(@"requestForOrderWithId:", ^{
    beforeEach(^{
      request = [LUOrderRequestFactory requestForOrderWithId:@1];
    });

    it(@"returns an authenticated request", ^{
      [[request should] beKindOfClass:[LUAuthenticatedAPIRequest class]];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'orders/<id>'", ^{
      [[request.path should] equal:@"orders/1"];
    });
  });
});

SPEC_END
