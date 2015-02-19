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

#import "LUPaymentTokenJSONFactory.h"

SPEC_BEGIN(LUPaymentTokenJSONFactorySpec)

describe(@"LUPaymentTokenJSONFactory", ^{
  __block LUPaymentTokenJSONFactory *factory;

  beforeEach(^{
    factory = [LUPaymentTokenJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUPaymentToken", ^{
      NSDictionary *JSON = @{
        @"action": @"add_payment_method",
        @"data": @"LU02000TESTTESTTEST01234",
        @"id": @1,
        @"message": @"Add a Payment Method for one-touch payments & loyalty"
      };
      LUPaymentToken *paymentToken = [factory createFromAttributes:JSON];

      [[paymentToken.action should] equal:@"add_payment_method"];
      [[paymentToken.data should] equal:@"LU02000TESTTESTTEST01234"];
      [[paymentToken.message should] equal:@"Add a Payment Method for one-touch payments & loyalty"];
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
