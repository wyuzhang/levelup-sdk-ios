// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LULocationCreditJSONFactory.h"
#import "LUMonetaryValue.h"

SPEC_BEGIN(LULocationCreditJSONFactorySpec)

describe(@"LULocationCreditJSONFactory", ^{
  __block LULocationCreditJSONFactory *factory;

  beforeEach(^{
    factory = [LULocationCreditJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUCredit", ^{
      NSDictionary *JSON = @{@"total_amount": @100};

      LUMonetaryValue *credit = [factory createFromAttributes:JSON];
      [[credit should] equal:[LUMonetaryValue monetaryValueWithUSCents:@100]];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'credit'", ^{
      [[[factory rootKey] should] equal:@"credit"];
    });
  });
});

SPEC_END
