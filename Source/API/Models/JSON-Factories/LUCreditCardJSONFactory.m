#import "LUCreditCard.h"
#import "LUCreditCardJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCreditCardJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *BIN = [attributes lu_stringForKey:@"bin"];
  NSString *creditCardDescription = [attributes lu_stringForKey:@"description"];
  NSNumber *creditCardID = [attributes lu_numberForKey:@"id"];
  NSNumber *expirationMonth = [attributes lu_numberForKey:@"expiration_month"];
  NSNumber *expirationYear = [attributes lu_numberForKey:@"expiration_year"];
  NSString *last4Digits = [attributes lu_stringForKey:@"last_4"];
  BOOL promoted = [attributes lu_boolForKey:@"promoted"];
  NSString *type = [attributes lu_stringForKey:@"type"];

  return [[LUCreditCard alloc] initWithBIN:BIN creditCardDescription:creditCardDescription creditCardID:creditCardID cvv:nil
                                             expirationMonth:expirationMonth expirationYear:expirationYear
                                                 last4Digits:last4Digits number:nil postalCode:nil promoted:promoted
                                                        type:type];
}

- (NSString *)rootKey {
  return @"credit_card";
}

@end
