// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "BTEncryption.h"
#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUCreditCard.h"
#import "LUCreditCardRequestFactory.h"

SPEC_BEGIN(LUCreditCardRequestFactorySpec)

describe(@"LUCreditCardRequestFactory", ^{
  // Public Methods

  __block LUAPIRequest *request;

  describe(@"requestForCreditCards", ^{
    beforeEach(^{
      request = [LUCreditCardRequestFactory requestForCreditCards];
    });

    it(@"returns a GET request", ^{
      [[request.method should] equal:@"GET"];
    });

    it(@"returns a request to the path 'credit_cards'", ^{
      [[request.path should] equal:@"credit_cards"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });
  });

  describe(@"requestToCreateCreditCard:", ^{
    __block LUCreditCard *creditCard;
    __block BTEncryption *braintree;

    beforeEach(^{
      braintree = [BTEncryption mock];
      [BTEncryption stub:@selector(alloc) andReturn:braintree];
      [braintree stub:@selector(initWithPublicKey:) andReturn:braintree];
      [(KWMock *)braintree stub:@selector(encryptString:) withBlock:^(NSArray *params) {
        return [NSString stringWithFormat:@"Encrypted: %@", params[0]];
      }];

      creditCard = [[LUCreditCard alloc] init];
      creditCard.cvv = @"123";
      creditCard.expirationMonth = @12;
      creditCard.expirationYear = @15;
      creditCard.number = @"4111111111111111";
      creditCard.postalCode = @"01234";

      request = [LUCreditCardRequestFactory requestToCreateCreditCard:creditCard];
    });

    it(@"returns a POST request", ^{
      [[request.method should] equal:@"POST"];
    });

    it(@"returns a request to the path 'credit_cards'", ^{
      [[request.path should] equal:@"credit_cards"];
    });

    it(@"returns a request to version 15 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion15];
    });

    it(@"returns a request with encrypted parameters for the credit card", ^{
      NSDictionary *expectedParams = @{
        @"credit_card" : @{
          @"encrypted_cvv" : [braintree encryptString:creditCard.cvv],
          @"encrypted_expiration_month" : [braintree encryptString:[creditCard.expirationMonth stringValue]],
          @"encrypted_expiration_year" : [braintree encryptString:[creditCard.expirationYear stringValue]],
          @"encrypted_number" : [braintree encryptString:creditCard.number],
          @"postal_code" : [braintree encryptString:creditCard.postalCode]
        }
      };

      [[request.parameters should] equal:expectedParams];
    });
  });

  describe(@"requestToDeleteCreditCardWithID:", ^{
    beforeEach(^{
      request = [LUCreditCardRequestFactory requestToDeleteCreditCardWithID:@1];
    });

    it(@"returns a DELETE request", ^{
      [[request.method should] equal:@"DELETE"];
    });

    it(@"returns a request to the path 'credit_cards/<id>'", ^{
      [[request.path should] equal:@"credit_cards/1"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });
  });

  describe(@"requestToPromoteCreditCardWithID:", ^{
    beforeEach(^{
      request = [LUCreditCardRequestFactory requestToPromoteCreditCardWithID:@1];
    });

    it(@"returns a PUT request", ^{
      [[request.method should] equal:@"PUT"];
    });

    it(@"returns a request to the path 'credit_cards/<id>'", ^{
      [[request.path should] equal:@"credit_cards/1"];
    });

    it(@"returns a request to version 14 of the API", ^{
      [[request.apiVersion should] equal:LUAPIVersion14];
    });
  });
});

SPEC_END
