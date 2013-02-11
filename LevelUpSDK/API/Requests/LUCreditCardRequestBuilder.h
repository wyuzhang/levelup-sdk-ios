@class LUAPIRequest;
@class LUCreditCard;

@interface LUCreditCardRequestBuilder : NSObject

+ (LUAPIRequest *)requestForCreditCards;
+ (LUAPIRequest *)requestToCreateCreditCard:(LUCreditCard *)creditCard;
+ (LUAPIRequest *)requestToDeleteCreditCardWithId:(NSNumber *)creditCardId;
+ (LUAPIRequest *)requestToPromoteCreditCardWithId:(NSNumber *)creditCardId;

@end
