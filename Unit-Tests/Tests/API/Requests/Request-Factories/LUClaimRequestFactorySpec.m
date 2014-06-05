// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUClaimRequestFactory.h"

SPEC_BEGIN(LUClaimRequestFactorySpec)

describe(@"LUClaimRequestFactory", ^{
  // Public Methods

  __block LUAPIRequest *request;

  describe(@"requestToClaimCampaignWithCode:", ^{
    NSString *code = @"testcode";

    beforeEach(^{
      request = [LUClaimRequestFactory requestToClaimCampaignWithCode:code];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'codes/<code>/claims'", ^{
      NSString *expectedPath = [NSString stringWithFormat:@"codes/%@/claims", code];

      [[request.path should] equal:expectedPath];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });
  });

  describe(@"requestToClaimLegacyLoyaltyWithID:campaignID:", ^{
    NSString *legacyLoyaltyID = @"abc123";
    NSNumber *campaignID = @2;

    beforeEach(^{
      request = [LUClaimRequestFactory requestToClaimLegacyLoyaltyWithID:legacyLoyaltyID campaignID:campaignID];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'loyalties/legacy/<campaignid>/claims'", ^{
      NSString *expectedPath = [NSString stringWithFormat:@"loyalties/legacy/%@/claims", campaignID];

      [[request.path should] equal:expectedPath];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });

    it(@"returns a request with parameters including the legacy loyalty id", ^{
      NSDictionary *expectedParams = @{@"legacy_loyalty" : @{@"legacy_id" : legacyLoyaltyID}};

      [[request.parameters should] equal:expectedParams];
    });
  });
});

SPEC_END
