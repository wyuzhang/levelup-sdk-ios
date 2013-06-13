#import "LUPaymentToken.h"
#import "LUPaymentTokenJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUPaymentTokenJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *data = [attributes stringForKey:@"data"];
  NSNumber *paymentTokenID = [attributes numberForKey:@"id"];

  return [[LUPaymentToken alloc] initWithData:data paymentTokenID:paymentTokenID];
}

- (NSString *)rootKey {
  return @"payment_token";
}

@end
