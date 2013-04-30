#import "LUBundle.h"
#import "LUBundleJSONFactory.h"
#import "LUMonetaryValueJSONFactory.h"
#import "LUOrderJSONFactory.h"
#import "LURefundJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUBundleJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  LUMonetaryValue *amount = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"amount"]];
  NSNumber *bundleID = [attributes numberForKey:@"id"];
  NSDate *chargeDate = [attributes dateForKey:@"charged_at"];
  BOOL closed = [[attributes stringForKey:@"state"] isEqualToString:@"closed"];
  NSDate *createdDate = [attributes dateForKey:@"created_at"];
  NSString *last4CreditCardDigits = [attributes stringForKey:@"last_4"];
  NSArray *orders = [[LUOrderJSONFactory factory] fromJSONObject:attributes[@"orders"]];
  NSArray *refunds = [[LURefundJSONFactory factory] fromJSONObject:attributes[@"refunds"]];
  LUMonetaryValue *totalCreditUsed = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"total_credit_used"]];

  return [[LUBundle alloc] initWithAmount:amount bundleID:bundleID chargeDate:chargeDate
                                   closed:closed createdDate:createdDate
                    last4CreditCardDigits:last4CreditCardDigits orders:orders refunds:refunds
                          totalCreditUsed:totalCreditUsed];
}

- (NSString *)rootKey {
  return @"bundle";
}

@end
