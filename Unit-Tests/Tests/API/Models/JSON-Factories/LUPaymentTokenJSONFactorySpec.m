// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUPaymentTokenJSONFactory.h"

SPEC_BEGIN(LUPaymentTokenJSONFactorySpec)

describe(@"LUPaymentTokenJSONFactory", ^{
  __block LUPaymentTokenJSONFactory *factory;

  beforeEach(^{
    factory = [LUPaymentTokenJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUPaymentToken", ^{
      LUPaymentToken *paymentToken = [factory createFromAttributes:[LUPaymentToken fullJSONObject]];

      [[paymentToken.data should] equal:@"LU02000TESTTESTTEST01234"];
      [[paymentToken.paymentTokenID should] equal:@1];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'payment_token'", ^{
      [[[factory rootKey] should] equal:@"payment_token"];
    });
  });
});

SPEC_END
