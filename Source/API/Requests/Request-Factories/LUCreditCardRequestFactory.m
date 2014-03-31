// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "BTEncryption.h"
#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUConstants.h"
#import "LUCreditCard.h"
#import "LUCreditCardJSONFactory.h"
#import "LUCreditCardRequestFactory.h"

@implementation LUCreditCardRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForCreditCards {
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:@"credit_cards"
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LUCreditCardJSONFactory factory]];
}

+ (LUAPIRequest *)requestToCreateCreditCard:(LUCreditCard *)creditCard {
  NSString *braintreePublicKey = [LUAPIClient sharedClient].clientsideEncryptionKey;
  BTEncryption *braintree = [[BTEncryption alloc] initWithPublicKey:braintreePublicKey];

  NSDictionary *parameters = @{
    @"encrypted_cvv" : [braintree encryptString:creditCard.cvv],
    @"encrypted_expiration_month" : [braintree encryptString:[creditCard.expirationMonth stringValue]],
    @"encrypted_expiration_year" : [braintree encryptString:[creditCard.expirationYear stringValue]],
    @"encrypted_number" : [braintree encryptString:creditCard.number],
    @"postal_code" : [braintree encryptString:creditCard.postalCode]
  };

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"credit_cards"
                                 apiVersion:LUAPIVersion14
                                 parameters:@{@"credit_card" : parameters}
                               modelFactory:[LUCreditCardJSONFactory factory]];
}

+ (LUAPIRequest *)requestToDeleteCreditCardWithID:(NSNumber *)creditCardID {
  NSString *path = [NSString stringWithFormat:@"credit_cards/%@", creditCardID];

  return [LUAPIRequest apiRequestWithMethod:@"DELETE"
                                       path:path
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LUCreditCardJSONFactory factory]];
}

+ (LUAPIRequest *)requestToPromoteCreditCardWithID:(NSNumber *)creditCardID {
  NSString *path = [NSString stringWithFormat:@"credit_cards/%@", creditCardID];

  return [LUAPIRequest apiRequestWithMethod:@"PUT"
                                       path:path
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LUCreditCardJSONFactory factory]];
}

@end
