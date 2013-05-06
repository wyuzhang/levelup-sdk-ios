#import "BraintreeEncryption.h"
#import "LUAPIClient.h"
#import "LUAuthenticatedAPIRequest.h"
#import "LUConstants.h"
#import "LUCreditCard.h"
#import "LUCreditCardJSONFactory.h"
#import "LUCreditCardRequestFactory.h"

@implementation LUCreditCardRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForCreditCards {
  NSString *path = [NSString stringWithFormat:@"users/%@/credit_cards", [LUAPIClient sharedClient].currentUserID];

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"GET"
                                                    path:path
                                              apiVersion:LUAPIVersion13
                                              parameters:nil
                                            modelFactory:[LUCreditCardJSONFactory factory]];
}

+ (LUAPIRequest *)requestToCreateCreditCard:(LUCreditCard *)creditCard {
  NSString *path = [NSString stringWithFormat:@"users/%@/credit_cards", [LUAPIClient sharedClient].currentUserID];

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

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"POST"
                                                    path:path
                                              apiVersion:LUAPIVersion13
                                              parameters:@{@"credit_card" : parameters}
                                            modelFactory:[LUCreditCardJSONFactory factory]];
}

+ (LUAPIRequest *)requestToDeleteCreditCardWithId:(NSNumber *)creditCardId {
  NSString *path = [NSString stringWithFormat:@"credit_cards/%@", creditCardId];

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"DELETE"
                                                    path:path
                                              apiVersion:LUAPIVersion13
                                              parameters:nil
                                            modelFactory:[LUCreditCardJSONFactory factory]];
}

+ (LUAPIRequest *)requestToPromoteCreditCardWithId:(NSNumber *)creditCardId {
  NSString *path = [NSString stringWithFormat:@"credit_cards/%@/promote", creditCardId];

  return [LUAuthenticatedAPIRequest apiRequestWithMethod:@"PUT"
                                                    path:path
                                              apiVersion:LUAPIVersion13
                                              parameters:nil
                                            modelFactory:[LUCreditCardJSONFactory factory]];
}

@end
