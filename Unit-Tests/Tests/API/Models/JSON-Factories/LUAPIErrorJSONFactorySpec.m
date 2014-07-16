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

#import "LUAPIError.h"
#import "LUAPIErrorJSONFactory.h"

SPEC_BEGIN(LUAPIErrorJSONFactorySpec)

describe(@"LUAPIErrorJSONFactory", ^{
  __block LUAPIErrorJSONFactory *factory;

  beforeEach(^{
    factory = [LUAPIErrorJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUAPIError", ^{
      NSDictionary *JSON = @{
        @"code" : @"code",
        @"message" : @"error message",
        @"object" : @"user",
        @"property" : @"first_name"
      };
      LUAPIError *error = [factory createFromAttributes:JSON];

      [[error.code should] equal:@"code"];
      [[error.message should] equal:@"error message"];
      [[error.object should] equal:@"user"];
      [[error.property should] equal:@"first_name"];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'error'", ^{
      [[[factory rootKey] should] equal:@"error"];
    });
  });
});

SPEC_END
