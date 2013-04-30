#import "LUCohortJSONFactory.h"

SPEC_BEGIN(LUCohortJSONFactorySpec)

describe(@"LUCohortJSONFactory", ^{
  __block LUCohortJSONFactory *factory;

  beforeEach(^{
    factory = [LUCohortJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUCohort", ^{
      LUCohort *cohort = [factory createFromAttributes:[LUCohort fullJSONObject]];

      [[cohort.campaign should] equal:[LUCampaign minimalCampaign]];
      [[cohort.code should] equal:@"code"];
      [[cohort.cohortDescription should] equal:@"description"];
      [[cohort.cohortID should] equal:@1];
      [[cohort.cohortType should] equal:@"type"];
      [[cohort.cohortURL should] equal:[NSURL URLWithString:@"http://example.com"]];
      [[cohort.emailBody should] equal:@"email body"];
      [[cohort.messageForEmailSubject should] equal:@"email subject"];
      [[cohort.messageForTwitter should] equal:@"twitter message"];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'cohort'", ^{
      [[[factory rootKey] should] equal:@"cohort"];
    });
  });
});

SPEC_END
