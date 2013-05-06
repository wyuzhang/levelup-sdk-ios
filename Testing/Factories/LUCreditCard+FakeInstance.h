#import "LUCreditCard.h"

@interface LUCreditCard (FakeInstance)

+ (LUCreditCard *)fakeInstance;
+ (LUCreditCard *)fakeInstanceWithExpirationMonth:(NSNumber *)expirationMonth expirationYear:(NSNumber *)expirationYear;
+ (LUCreditCard *)fakeInstanceWithID:(NSNumber *)creditCardID;

@end
