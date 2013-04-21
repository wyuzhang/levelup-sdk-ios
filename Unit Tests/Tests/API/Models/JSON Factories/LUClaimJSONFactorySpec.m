#import "LUClaimJSONFactory.h"

SPEC_BEGIN(LUClaimJSONFactorySpec)

describe(@"LUClaimJSONFactory", ^{
  __block LUClaimJSONFactory *factory;

  beforeEach(^{
    factory = [LUClaimJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUClaim", ^{
      LUClaim *claim = [factory createFromAttributes:[LUClaim fullJSONObject]];

      [[claim.campaign should] equal:[LUCampaign minimalCampaign]];
      [[claim.claimID should] equal:@1];
      [[claim.cohort should] equal:[LUCohort minimalCohort]];
      [[claim.shareCohort should] equal:[LUCohort minimalCohort]];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'claim'", ^{
      [[[factory rootKey] should] equal:@"claim"];
    });
  });
});

SPEC_END
