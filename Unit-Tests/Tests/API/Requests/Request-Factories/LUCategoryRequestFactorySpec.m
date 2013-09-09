// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIRequest.h"
#import "LUCategoryRequestFactory.h"

SPEC_BEGIN(LUCategoryRequestFactorySpec)

describe(@"LUCategoryRequestFactory", ^{
  // Public Methods

  describe(@"requestForAllCategories", ^{
    __block LUAPIRequest *request;

    beforeEach(^{
      request = [LUCategoryRequestFactory requestForAllCategories];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'categories'", ^{
      [[request.path should] equal:@"categories"];
    });

    it(@"returns a request to version 13 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion13];
    });

    it(@"returns a request with no parameters", ^{
      [request.parameters shouldBeNil];
    });
  });

  describe(@"requestForAllCauseCategories", ^{
    __block LUAPIRequest *request;

    beforeEach(^{
      request = [LUCategoryRequestFactory requestForAllCauseCategories];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'cause_categories'", ^{
      [[request.path should] equal:@"cause_categories"];
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
