#import "LUCreditCard+FakeInstance.h"

@implementation LUCreditCard (FakeInstance)

+ (LUCreditCard *)fakeInstance {
  return [[LUCreditCard alloc] initWithBIN:@"1234" creditCardDescription:@"Visa ending in 1234" creditCardID:@1 cvv:nil
                           expirationMonth:@11 expirationYear:@2013 last4Digits:@"1234" number:nil postalCode:@"01234"
                                  promoted:NO type:@"Visa"];
}

+ (LUCreditCard *)fakeInstanceWithExpirationMonth:(NSNumber *)expirationMonth expirationYear:(NSNumber *)expirationYear {
  LUCreditCard *creditCard = [self fakeInstance];
  [creditCard setValue:expirationMonth forKey:@"expirationMonth"];
  [creditCard setValue:expirationYear forKey:@"expirationYear"];
  return creditCard;
}

+ (LUCreditCard *)fakeInstanceWithID:(NSNumber *)creditCardID {
  LUCreditCard *creditCard = [self fakeInstance];
  [creditCard setValue:creditCardID forKey:@"creditCardID"];
  return creditCard;
}

@end
