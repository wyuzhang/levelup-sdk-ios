#import "LUAPIRequest.h"
#import "LUCohortRequestFactory.h"

SPEC_BEGIN(LUCohortRequestFactorySpec)

describe(@"LUCohortRequestFactory", ^{
  // Public Methods

  describe(@"requestForCohortWithCode:", ^{
    __block LUAPIRequest *request;
    NSString *cohortCode = @"abcdefg";

    beforeEach(^{
      request = [LUCohortRequestFactory requestForCohortWithCode:cohortCode];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'cohorts/<userid>'", ^{
      NSString *expectedPath = [NSString stringWithFormat:@"cohorts/%@", cohortCode];

      [[request.path should] equal:expectedPath];
    });

    it(@"returns a request with no parameters", ^{
      [request.parameters shouldBeNil];
    });
  });
});

SPEC_END
