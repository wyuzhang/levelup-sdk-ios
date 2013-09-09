// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUMonetaryValueJSONFactory.h"

SPEC_BEGIN(LUMonetaryValueJSONFactorySpec)

describe(@"LUMonetaryValueJSONFactory", ^{
  __block LUMonetaryValueJSONFactory *factory;

  beforeEach(^{
    factory = [LUMonetaryValueJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUMonetaryValue", ^{
      LUMonetaryValue *monetaryValue = [factory createFromAttributes:[LUMonetaryValue fullJSONObject]];

      [[monetaryValue.amount should] equal:@1000];
      [[monetaryValue.currencyCode should] equal:@"USD"];
      [[monetaryValue.currencySymbol should] equal:@"$"];
      [[monetaryValue.formattedAmount should] equal:@"10.00"];
    });
  });

  describe(@"rootKey", ^{
    it(@"is nil", ^{
      [[factory rootKey] shouldBeNil];
    });
  });
});

SPEC_END
