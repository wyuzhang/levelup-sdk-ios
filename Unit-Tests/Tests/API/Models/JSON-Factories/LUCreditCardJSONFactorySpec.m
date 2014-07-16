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

#import "LUCreditCardJSONFactory.h"

SPEC_BEGIN(LUCreditCardJSONFactorySpec)

describe(@"LUCreditCardJSONFactory", ^{
  __block LUCreditCardJSONFactory *factory;

  beforeEach(^{
    factory = [LUCreditCardJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUCreditCard", ^{
      NSDictionary *JSON = @{
        @"debit": @YES,
        @"description": @"description",
        @"id" : @1,
        @"expiration_month" : @11,
        @"expiration_year" : @13,
        @"last_4" : @"1234",
        @"promoted" : @YES,
        @"type" : @"visa"
      };
      LUCreditCard *creditCard = [factory createFromAttributes:JSON];

      [[creditCard.creditCardDescription should] equal:@"description"];
      [[creditCard.creditCardID should] equal:@1];
      [[theValue(creditCard.debit) should] beYes];
      [[creditCard.expirationMonth should] equal:@11];
      [[creditCard.expirationYear should] equal:@13];
      [[creditCard.last4Digits should] equal:@"1234"];
      [[theValue(creditCard.promoted) should] beYes];
      [[creditCard.type should] equal:@"visa"];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'credit_card'", ^{
      [[[factory rootKey] should] equal:@"credit_card"];
    });
  });
});

SPEC_END
