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

    it(@"returns a request to the path 'cause_affiliation'", ^{
      [[request.path should] equal:@"cause_affiliation"];
    });

    it(@"returns a request to version 13 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion13];
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

    it(@"returns a request to the path 'cause_affiliation'", ^{
      [[request.path should] equal:@"cause_affiliation"];
    });

    it(@"returns a request to version 13 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion13];
    });
  });

  describe(@"requestToSetCauseId:", ^{
    LUCauseAffiliation *causeAffiliation = [LUCauseAffiliation fakeInstance];

    beforeEach(^{
      request = [LUCauseAffiliationRequestFactory requestToCreateCauseAffiliation:causeAffiliation];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'cause_affiliation'", ^{
      [[request.path should] equal:@"cause_affiliation"];
    });

    it(@"returns a request to version 13 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion13];
    });

    it(@"returns a request with parameters for the cause affiliation", ^{
      NSDictionary *expectedParams = @{
        @"cause_id" : causeAffiliation.causeID,
        @"percent_donation" : causeAffiliation.percentDonation
      };

      [[request.parameters should] equal:expectedParams];
    });
  });
});

SPEC_END
