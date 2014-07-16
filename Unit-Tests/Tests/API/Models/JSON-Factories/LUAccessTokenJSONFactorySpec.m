/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "LUAccessTokenJSONFactory.h"

SPEC_BEGIN(LUAccessTokenJSONFactorySpec)

describe(@"LUAccessTokenJSONFactory", ^{
  __block LUAccessTokenJSONFactory *factory;

  beforeEach(^{
    factory = [LUAccessTokenJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUAccessToken", ^{
      NSDictionary *JSON = @{ @"token" : @"access-token", @"user_id" : @1 };
      LUAccessToken *accessToken = [factory createFromAttributes:JSON];

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
