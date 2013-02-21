#import "LUOrderModelBuilder.h"
#import "LURefund.h"
#import "LURefundModelBuilder.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LURefundModelBuilder

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  if (attributes[@"refund"]) {
    attributes = attributes[@"refund"];
  }

  LURefund *refund = [[LURefund alloc] init];
  refund.createdAt = [attributes dateForKey:@"created_at"];
  refund.order = [[LUOrderModelBuilder builder] buildModelFromJSON:attributes[@"order"]];
  refund.refundID = [attributes numberForKey:@"id"];

  return refund;
}

@end
