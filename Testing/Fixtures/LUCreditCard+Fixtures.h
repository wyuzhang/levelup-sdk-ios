// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUCreditCard.h"

@interface LUCreditCard (Fixtures)

+ (LUCreditCard *)fixture;
+ (LUCreditCard *)fixtureForPromotedCard;
+ (LUCreditCard *)fixtureWithExpirationMonth:(NSNumber *)expirationMonth expirationYear:(NSNumber *)expirationYear;
+ (LUCreditCard *)fixtureWithID:(NSNumber *)creditCardID;

@end
