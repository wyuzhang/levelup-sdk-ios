#import "BraintreeEncryption.h"
#import "LUConstants.h"
#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUCreditCard.h"
#import "LUCreditCardRequest.h"

@implementation LUCreditCardRequest

+ (LUAPIRequest *)createCreditCard:(LUCreditCard *)creditCard {
  NSString *path = [NSString stringWithFormat:@"users/%@/credit_cards", [LUAPIClient sharedClient].currentUserId];

  NSString *braintreePublicKey;
  if ([LUAPIClient sharedClient].developmentMode) {
    braintreePublicKey = BraintreePublicKeyDevelopment;
  } else {
    braintreePublicKey = BraintreePublicKeyProduction;
  }

  BraintreeEncryption *braintree = [[BraintreeEncryption alloc] initWithPublicKey:braintreePublicKey];
  NSDictionary *parameters = @{
    @"cvv" : [braintree encryptString:creditCard.cvv],
    @"expiration_month" : [braintree encryptString:[creditCard.expirationMonth stringValue]],
    @"expiration_year" : [braintree encryptString:[creditCard.expirationYear stringValue]],
    @"number" : [braintree encryptString:creditCard.number],
    @"postal_code" : [braintree encryptString:creditCard.postalCode]
  };

  return [LUAPIRequest apiRequestWithMethod:@"POST" path:path parameters:@{@"credit_card" : parameters}];
}

+ (LUAPIRequest *)deleteCreditCard:(LUCreditCard *)creditCard {
  NSString *path = [NSString stringWithFormat:@"credit_cards/%@", creditCard.modelId];

  return [LUAPIRequest apiRequestWithMethod:@"DELETE" path:path parameters:nil];
}

+ (LUAPIRequest *)getCreditCards {
  NSString *path = [NSString stringWithFormat:@"users/%@/credit_cards", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest apiRequestWithMethod:@"GET" path:path parameters:nil];
}

+ (LUAPIRequest *)promoteCreditCardWithId:(NSNumber *)creditCardId {
  NSString *path = [NSString stringWithFormat:@"credit_cards/%@/promote", creditCardId];

  return [LUAPIRequest apiRequestWithMethod:@"PUT" path:path parameters:nil];
}

@end
