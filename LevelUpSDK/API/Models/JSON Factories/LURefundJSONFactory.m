#import "LUOrderJSONFactory.h"
#import "LURefund.h"
#import "LURefundJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LURefundJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSDate *createdDate = [attributes dateForKey:@"created_at"];
  LUOrder *order = [[LUOrderJSONFactory factory] fromJSONObject:attributes[@"order"]];
  NSNumber *refundID = [attributes numberForKey:@"id"];

  return [[LURefund alloc] initWithCreatedDate:createdDate order:order refundID:refundID];
}

- (NSString *)rootKey {
  return @"refund";
}

@end
