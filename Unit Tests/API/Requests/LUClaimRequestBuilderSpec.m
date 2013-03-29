#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUClaimRequestBuilder.h"
#import "LUCohort.h"

SPEC_BEGIN(LUClaimRequestBuilderSpec)

describe(@"LUClaimRequestBuilder", ^{
  // Public Methods

  __block LUAPIRequest *request;

  describe(@"requestToClaimCohort:", ^{
    LUCohort *cohort = [[LUCohort alloc] init];
    cohort.code = @"ABCDEF";

    beforeEach(^{
      [[LUAPIClient sharedClient] stub:@selector(currentUserId) andReturn:@1];

      request = [LUClaimRequestBuilder requestToClaimCohort:cohort];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'users/<userid>/claims'", ^{
      [[request.path should] equal:@"users/1/claims"];
    });

    it(@"returns a request with parameters for the cohort's code", ^{
      NSDictionary *expectedParams = @{@"claim" : @{@"cohort_code" : cohort.code }};

      [[request.parameters should] equal:expectedParams];
    });
  });

  describe(@"requestToClaimLegacyLoyaltyWithId:campaignId:", ^{
    NSString *legacyLoyaltyId = @"abc123";
    NSNumber *campaignId = @2;

    beforeEach(^{
      request = [LUClaimRequestBuilder requestToClaimLegacyLoyaltyWithId:legacyLoyaltyId campaignId:campaignId];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'loyalties/legacy/<campaignid>/claims'", ^{
      NSString *expectedPath = [NSString stringWithFormat:@"loyalties/legacy/%@/claims", campaignId];

      [[request.path should] equal:expectedPath];
    });

    it(@"returns a request with parameters including the legacy loyalty id", ^{
      [[request.parameters should] equal:@{@"legacy_id": legacyLoyaltyId}];
    });
  });
});

SPEC_END
