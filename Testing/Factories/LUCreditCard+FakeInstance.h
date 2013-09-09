// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUCreditCard.h"

@interface LUCreditCard (FakeInstance)

+ (LUCreditCard *)fakeInstance;
+ (LUCreditCard *)fakeInstanceForPromotedCard;
+ (LUCreditCard *)fakeInstanceWithExpirationMonth:(NSNumber *)expirationMonth expirationYear:(NSNumber *)expirationYear;
+ (LUCreditCard *)fakeInstanceWithID:(NSNumber *)creditCardID;

@end
