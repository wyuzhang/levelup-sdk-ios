#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUAuthenticatedAPIRequest.h"
#import "LUCauseAffiliationRequestFactory.h"

SPEC_BEGIN(LUCauseAffiliationRequestFactorySpec)

describe(@"LUCauseAffiliationRequestFactory", ^{
  __block LUAPIRequest *request;

  // Public Methods

  describe(@"requestForCauseAffiliation", ^{
    beforeEach(^{
      [[LUAPIClient sharedClient] stub:@selector(currentUserID) andReturn:@1];

      request = [LUCauseAffiliationRequestFactory requestForCauseAffiliation];
    });

    it(@"returns an authenticated request", ^{
      [[request should] beKindOfClass:[LUAuthenticatedAPIRequest class]];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'causes/affiliation'", ^{
      [[request.path should] equal:@"/causes/affiliation"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });
  });

  describe(@"requestToRemoveCauseAffiliation", ^{
    beforeEach(^{
      request = [LUCauseAffiliationRequestFactory requestToRemoveCauseAffiliation];
    });

    it(@"returns an authenticated request", ^{
      [[request should] beKindOfClass:[LUAuthenticatedAPIRequest class]];
    });

    it(@"returns a DELETE request", ^{
      [[request.method should] equal:@"DELETE"];
    });

    it(@"returns a request to the path 'causes/affiliation'", ^{
      [[request.path should] equal:@"/causes/affiliation"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });
  });

  describe(@"requestToSetCauseId:", ^{
    LUCauseAffiliation *causeAffiliation = [LUCauseAffiliation fakeInstance];

    beforeEach(^{
      request = [LUCauseAffiliationRequestFactory requestToCreateCauseAffiliation:causeAffiliation];
    });

    it(@"returns a PUT request", ^{
      [[request.method should] equal:@"PUT"];
    });

    it(@"returns a request to the path 'causes/affiliation'", ^{
      [[request.path should] equal:@"/causes/affiliation"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request with parameters for the causeId", ^{
      NSDictionary *expectedParams = @{
        @"cause_affiliation" : @{
          @"cause_id" : causeAffiliation.causeID,
          @"percent_donation" : causeAffiliation.percentDonation
        }
      };

      [[request.parameters should] equal:expectedParams];
    });
  });
});

SPEC_END
