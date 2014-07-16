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

#import "LUCreditCard+Fixtures.h"

@implementation LUCreditCard (Fixtures)

+ (LUCreditCard *)fixture {
  return [[LUCreditCard alloc] initWithBIN:@"1234" creditCardDescription:@"Visa ending in 1234" creditCardID:@1 cvv:nil debit:NO
                           expirationMonth:@11 expirationYear:@2013 last4Digits:@"1234" number:nil postalCode:@"01234"
                                  promoted:NO type:@"Visa"];
}

+ (LUCreditCard *)fixtureForDebitCard {
  LUCreditCard *creditCard = [self fixture];
  [creditCard setValue:@YES forKey:@"debit"];
  return creditCard;
}

+ (LUCreditCard *)fixtureForPromotedCard {
  LUCreditCard *creditCard = [self fixture];
  [creditCard setValue:@YES forKey:@"promoted"];
  return creditCard;
}

+ (LUCreditCard *)fixtureWithExpirationMonth:(NSNumber *)expirationMonth expirationYear:(NSNumber *)expirationYear {
  LUCreditCard *creditCard = [self fixture];
  [creditCard setValue:expirationMonth forKey:@"expirationMonth"];
  [creditCard setValue:expirationYear forKey:@"expirationYear"];
  return creditCard;
}

+ (LUCreditCard *)fixtureWithID:(NSNumber *)creditCardID {
  LUCreditCard *creditCard = [self fixture];
  [creditCard setValue:creditCardID forKey:@"creditCardID"];
  return creditCard;
}

@end
