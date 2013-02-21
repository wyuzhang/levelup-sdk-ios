#import "LUCreditCard.h"
#import "LUCreditCardModelBuilder.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCreditCardModelBuilder

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  if (attributes[@"credit_card"]) {
    attributes = attributes[@"credit_card"];
  }

  LUCreditCard *creditCard = [[LUCreditCard alloc] init];
  creditCard.creditCardDescription = [attributes stringForKey:@"description"];
  creditCard.creditCardID = [attributes numberForKey:@"id"];
  creditCard.expirationMonth = [attributes numberForKey:@"expiration_month"];
  creditCard.expirationYear = [attributes numberForKey:@"expiration_year"];
  creditCard.last4Digits = [attributes stringForKey:@"last_4"];
  creditCard.promoted = [attributes boolForKey:@"promoted"];
  creditCard.type = [attributes stringForKey:@"type"];

  return creditCard;
}

@end
