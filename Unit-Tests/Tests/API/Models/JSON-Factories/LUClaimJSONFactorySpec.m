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

#import "LUClaimJSONFactory.h"

SPEC_BEGIN(LUClaimJSONFactorySpec)

describe(@"LUClaimJSONFactory", ^{
  __block LUClaimJSONFactory *factory;

  beforeEach(^{
    factory = [LUClaimJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUClaim", ^{
      NSDictionary *JSON = @{
        @"code" : @"test-code",
        @"id" : @1,
        @"value_amount" : @500,
        @"value_remaining_amount" : @300
      };
      LUClaim *claim = [factory createFromAttributes:JSON];

      [[claim.code should] equal:@"test-code"];
      [[claim.claimID should] equal:@1];
      [[claim.value should] equal:[LUMonetaryValue monetaryValueWithUSCents:@500]];
      [[claim.valueRemaining should] equal:[LUMonetaryValue monetaryValueWithUSCents:@300]];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'claim'", ^{
      [[[factory rootKey] should] equal:@"claim"];
    });
  });
});

SPEC_END
