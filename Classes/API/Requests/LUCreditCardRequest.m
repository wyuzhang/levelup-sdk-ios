#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUCreditCard.h"
#import "LUCreditCardRequest.h"

@implementation LUCreditCardRequest

+ (LUAPIRequest *)createCreditCard:(LUCreditCard *)creditCard {
  NSString *path = [NSString stringWithFormat:@"users/%@/credit_cards", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest authenticatedApiRequestWithMethod:@"POST" path:path parameters:@{@"credit_card" : creditCard.parameters}];
}

+ (LUAPIRequest *)deleteCreditCard:(LUCreditCard *)creditCard {
  NSString *path = [NSString stringWithFormat:@"credit_cards/%@", creditCard.modelId];

  return [LUAPIRequest authenticatedApiRequestWithMethod:@"DELETE" path:path parameters:nil];
}

+ (LUAPIRequest *)getCreditCards {
  NSString *path = [NSString stringWithFormat:@"users/%@/credit_cards", [LUAPIClient sharedClient].currentUserId];

  return [LUAPIRequest authenticatedApiRequestWithMethod:@"GET" path:path parameters:nil];
}

+ (LUAPIRequest *)promoteCreditCardWithId:(NSNumber *)creditCardId {
  NSString *path = [NSString stringWithFormat:@"credit_cards/%@/promote", creditCardId];

  return [LUAPIRequest authenticatedApiRequestWithMethod:@"PUT" path:path parameters:nil];
}

@end
