#import <Foundation/Foundation.h>

@class LUAPIRequest;
@class LUCreditCard;

@interface LUCreditCardRequest : NSObject

+ (LUAPIRequest *)createCreditCard:(LUCreditCard *)creditCard;
+ (LUAPIRequest *)deleteCreditCard:(LUCreditCard *)creditCard;
+ (LUAPIRequest *)getCreditCards;
+ (LUAPIRequest *)promoteCreditCardWithId:(NSNumber *)creditCardId;

@end
