/**
 `LUCreditCardRequestBuilder` is used to build requests related to credit cards.
 */
@class LUAPIRequest;
@class LUCreditCard;

@interface LUCreditCardRequestBuilder : NSObject

/**
 Builds a request to return all credit cards added by the current user.

 On success, this request will return an array of `LUCreditCard` instances.
 */
+ (LUAPIRequest *)requestForCreditCards;

/**
 Builds a request to create a credit card.

 On success, this request will return the newly created `LUCreditCard`.

 @param creditCard The `LUCreditCard` to create.
 */
+ (LUAPIRequest *)requestToCreateCreditCard:(LUCreditCard *)creditCard;

/**
 Builds a request to delete a credit card.

 On success, this request will return the deleted `LUCreditCard`.

 @param creditCardId The ID of a credit card to delete.
 */
+ (LUAPIRequest *)requestToDeleteCreditCardWithId:(NSNumber *)creditCardId;

/**
 Builds a request to promote a credit card.

 The promoted card will be the first attempted when charging a user. When a credit card is promoted, if there is another
 promoted card, that card will be un-promoted.

 On success, this request will return the `LUCreditCard` that was promoted.

 @param creditCardId The ID of a credit card to promote.
 */
+ (LUAPIRequest *)requestToPromoteCreditCardWithId:(NSNumber *)creditCardId;

@end
