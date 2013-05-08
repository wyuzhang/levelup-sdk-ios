#import "LUCauseAffiliationJSONFactory.h"

SPEC_BEGIN(LUCauseAffiliationJSONFactorySpec)

describe(@"LUCauseAffiliationJSONFactory", ^{
  __block LUCauseAffiliationJSONFactory *factory;

  beforeEach(^{
    factory = [LUCauseAffiliationJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUCause", ^{
      LUCauseAffiliation *causeAffiliation = [factory createFromAttributes:[LUCauseAffiliation fullJSONObject]];

      [[causeAffiliation.causeID should] equal:@1];
      [[causeAffiliation.percentDonation should] equal:@50];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'user'", ^{
      [[[factory rootKey] should] equal:@"cause_affiliation"];
    });
  });
});

SPEC_END
