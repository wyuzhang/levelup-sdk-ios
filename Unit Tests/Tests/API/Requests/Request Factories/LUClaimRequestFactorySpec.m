#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUClaimRequestFactory.h"
#import "LUCohort.h"

SPEC_BEGIN(LUClaimRequestFactorySpec)

describe(@"LUClaimRequestFactory", ^{
  // Public Methods

  __block LUAPIRequest *request;

  describe(@"requestToClaimCohort:", ^{
    LUCohort *cohort = [[LUCohort alloc] initWithCampaign:nil code:@"ABCDEF" cohortDescription:nil
                                                 cohortID:nil cohortType:nil cohortURL:nil
                                                emailBody:nil messageForEmailSubject:nil
                                        messageForTwitter:nil];

    beforeEach(^{
      [[LUAPIClient sharedClient] stub:@selector(currentUserID) andReturn:@1];

      request = [LUClaimRequestFactory requestToClaimCohort:cohort];
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
      request = [LUClaimRequestFactory requestToClaimLegacyLoyaltyWithId:legacyLoyaltyId campaignId:campaignId];
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
