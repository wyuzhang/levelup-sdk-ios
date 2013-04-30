#import "LUCreditCard.h"
#import "LUCreditCardJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCreditCardJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *creditCardDescription = [attributes stringForKey:@"description"];
  NSNumber *creditCardID = [attributes numberForKey:@"id"];
  NSNumber *expirationMonth = [attributes numberForKey:@"expiration_month"];
  NSNumber *expirationYear = [attributes numberForKey:@"expiration_year"];
  NSString *last4Digits = [attributes stringForKey:@"last_4"];
  BOOL promoted = [attributes boolForKey:@"promoted"];
  NSString *type = [attributes stringForKey:@"type"];

  return [[LUCreditCard alloc] initWithCreditCardDescription:creditCardDescription creditCardID:creditCardID cvv:nil
                                             expirationMonth:expirationMonth expirationYear:expirationYear
                                                 last4Digits:last4Digits number:nil postalCode:nil promoted:promoted
                                                        type:type];
}

- (NSString *)rootKey {
  return @"credit_card";
}

@end
