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
      NSDictionary *JSON = @{
        @"amount" : @1000,
        @"currency_code" : @"USD",
        @"currency_symbol" : @"$",
        @"formatted_amount" : @"10.00"
      };
      LUMonetaryValue *monetaryValue = [factory createFromAttributes:JSON];

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
