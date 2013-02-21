#import "LUBundle.h"
#import "LUBundleModelBuilder.h"
#import "LUOrderModelBuilder.h"
#import "LURefundModelBuilder.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUBundleModelBuilder

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  if (attributes[@"bundle"]) {
    attributes = attributes[@"bundle"];
  }

  LUBundle *bundle = [[LUBundle alloc] init];
  bundle.amount = [attributes monetaryValueForKey:@"amount"];
  bundle.bundleID = [attributes numberForKey:@"id"];
  bundle.chargedAt = [attributes dateForKey:@"charged_at"];
  bundle.createdAt = [attributes dateForKey:@"created_at"];
  bundle.last4CreditCardDigits = [attributes stringForKey:@"last_4"];
  bundle.orders = [[LUOrderModelBuilder builder] buildModelFromJSON:attributes[@"orders"]];
  bundle.refunds = [[LURefundModelBuilder builder] buildModelFromJSON:attributes[@"refunds"]];
  bundle.totalCreditUsed = [attributes monetaryValueForKey:@"total_credit_used"];

  return bundle;
}

@end
