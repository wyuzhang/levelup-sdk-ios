#import "LUOAuthTokenJSONFactory.h"

SPEC_BEGIN(LUOAuthTokenJSONFactorySpec)

describe(@"LUOAuthTokenJSONFactory", ^{
  __block LUOAuthTokenJSONFactory *factory;

  beforeEach(^{
    factory = [LUOAuthTokenJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUOAuthToken", ^{
      LUOAuthToken *oauthToken = [factory createFromAttributes:[LUOAuthToken fullJSONObject]];

      [[oauthToken.accessToken should] equal:@"access-token"];
      [[oauthToken.xUserID should] equal:@1];
    });
  });

  describe(@"rootKey", ^{
    it(@"is nil", ^{
      [[factory rootKey] shouldBeNil];
    });
  });
});

SPEC_END
