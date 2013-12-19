// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUCreditCard+Fixtures.h"

@implementation LUCreditCard (Fixtures)

+ (LUCreditCard *)fixture {
  return [[LUCreditCard alloc] initWithBIN:@"1234" creditCardDescription:@"Visa ending in 1234" creditCardID:@1 cvv:nil
                           expirationMonth:@11 expirationYear:@2013 last4Digits:@"1234" number:nil postalCode:@"01234"
                                  promoted:NO type:@"Visa"];
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
