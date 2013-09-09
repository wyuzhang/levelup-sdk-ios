// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAccessTokenJSONFactory.h"

SPEC_BEGIN(LUAccessTokenJSONFactorySpec)

describe(@"LUAccessTokenJSONFactory", ^{
  __block LUAccessTokenJSONFactory *factory;

  beforeEach(^{
    factory = [LUAccessTokenJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUAccessToken", ^{
      LUAccessToken *accessToken = [factory createFromAttributes:[LUAccessToken fullJSONObject]];

      [[accessToken.token should] equal:@"access-token"];
      [[accessToken.userID should] equal:@1];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'access_token'", ^{
      [[[factory rootKey] should] equal:@"access_token"];
    });
  });
});

SPEC_END
