#import "LUAPIRequest.h"
#import "LUCategoryRequestBuilder.h"

SPEC_BEGIN(LUCategoryRequestBuilderSpec)

describe(@"LUCategoryRequestBuilder", ^{
  // Public Methods

  describe(@"requestForAllCategories", ^{
    __block LUAPIRequest *request;

    beforeEach(^{
      request = [LUCategoryRequestBuilder requestForAllCategories];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'categories'", ^{
      [[request.path should] equal:@"categories"];
    });

    it(@"returns a request with no parameters", ^{
      [request.parameters shouldBeNil];
    });
  });

  describe(@"requestForAllCauseCategories", ^{
    __block LUAPIRequest *request;

    beforeEach(^{
      request = [LUCategoryRequestBuilder requestForAllCauseCategories];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'cause_categories'", ^{
      [[request.path should] equal:@"cause_categories"];
    });

    it(@"returns a request with no parameters", ^{
      [request.parameters shouldBeNil];
    });
  });
});

SPEC_END
