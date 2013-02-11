#import "LUAPIRequest.h"
#import "LUDivisionRequestBuilder.h"

SPEC_BEGIN(LUDivisionRequestBuilderSpec)

describe(@"LUDivisionRequestBuilder", ^{
  // Public Methods

  describe(@"requestForAllDivisions", ^{
    __block LUAPIRequest *request;

    beforeEach(^{
      request = [LUDivisionRequestBuilder requestForAllDivisions];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'divisions'", ^{
      [[request.path should] equal:@"divisions"];
    });

    it(@"returns a request with no parameters", ^{
      [request.parameters shouldBeNil];
    });
  });
});

SPEC_END
