#import "LUAPIModel.h"

/**
 A user's credit card to use for billing. Users can have any number of credit cards, but one will be marked as
 `promoted`, which mean it will be the first card attempted when a new charge needs to be made.
 */
@interface LUCreditCard : LUAPIModel

/**
 A string to use when describing the credit card. Includes the card's type and last 4 digits.
 */
@property (nonatomic, copy) NSString *creditCardDescription;

/**
 The unique identifier for this category.
 */
@property (nonatomic, copy) NSNumber *creditCardID;

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
@property (nonatomic, copy) NSString *last4Digits;

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
@property (nonatomic, copy) NSString *type;

@end
