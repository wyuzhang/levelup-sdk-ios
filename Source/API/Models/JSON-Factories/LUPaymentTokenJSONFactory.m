#import "LUPaymentToken.h"
#import "LUPaymentTokenJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUPaymentTokenJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *data = [attributes lu_stringForKey:@"data"];
  NSNumber *paymentTokenID = [attributes lu_numberForKey:@"id"];

  return [[LUPaymentToken alloc] initWithData:data paymentTokenID:paymentTokenID];
}

- (NSString *)rootKey {
  return @"payment_token";
}

@end
