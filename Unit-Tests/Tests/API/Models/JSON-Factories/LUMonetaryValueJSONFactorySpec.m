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
