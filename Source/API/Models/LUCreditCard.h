// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIModel.h"

/**
 A user's credit card to use for billing. Users can have any number of credit cards, but one will be marked as
 `promoted`, which mean it will be the first card attempted when a new charge needs to be made.
 */
@interface LUCreditCard : LUAPIModel

/**
 A string representing the BIN for the card in Braintree. This can be used to identify the origin of a specific card.
 */
@property (nonatomic, copy, readonly) NSString *BIN;

/**
 A string that describes the credit card. Includes the card's type and last 4 digits.
 */
@property (nonatomic, copy, readonly) NSString *creditCardDescription;

/**
 The unique identifier for this credit card.
 */
@property (nonatomic, copy, readonly) NSNumber *creditCardID;

/**
 The credit card's CVV (card verification value).
 */
@property (nonatomic, copy) NSString *cvv;

/**
 The card's expiration month, as a number from 1 to 12.
 */
@property (nonatomic, copy) NSNumber *expirationMonth;

/**
 The card's expiration year as a four digit number (e.g. 2013).
 */
@property (nonatomic, copy) NSNumber *expirationYear;

/**
 The last 4 digits of the credit card. This is returned by the server, and does not need to be set when creating a new
 card.
 */
@property (nonatomic, copy, readonly) NSString *last4Digits;

/**
 The credit card number. Should be set when creating a credit card. Will be nil when retrieving cards from the server.
 */
@property (nonatomic, copy) NSString *number;

/**
 The postal code (zip code) associated with the card.
 */
@property (nonatomic, copy) NSString *postalCode;

/**
 Specifies if the card is currently promoted.
 */
@property (nonatomic, assign) BOOL promoted;

/**
 The credit card type (e.g. Visa, MasterCard, etc). This will be returned by the server, but is not required when
 creating credit cards.
 */
@property (nonatomic, copy, readonly) NSString *type;

- (id)initWithBIN:(NSString *)BIN creditCardDescription:(NSString *)creditCardDescription creditCardID:(NSNumber *)creditCardID
                                cvv:(NSString *)cvv expirationMonth:(NSNumber *)expirationMonth
                     expirationYear:(NSNumber *)expirationYear last4Digits:(NSString *)last4Digits
                             number:(NSString *)number postalCode:(NSString *)postalCode promoted:(BOOL)promoted
                               type:(NSString *)type;

@end
