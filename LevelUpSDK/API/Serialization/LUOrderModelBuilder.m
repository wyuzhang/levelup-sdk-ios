#import "LUDonationModelBuilder.h"
#import "LUInterstitialActionModelBuilder.h"
#import "LULocationModelBuilder.h"
#import "LULoyaltyModelBuilder.h"
#import "LUMerchantModelBuilder.h"
#import "LUOrder.h"
#import "LUOrderModelBuilder.h"
#import "NSDate+StringFormats.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUOrderModelBuilder

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  if (attributes[@"order"]) {
    attributes = attributes[@"order"];
  }

  LUOrder *order = [[LUOrder alloc] init];
  order.balance = [attributes monetaryValueForKey:@"balance"];
  order.closed = [attributes boolForKey:@"bundle_closed"];
  order.createdAt = [NSDate dateFromIso8601DateTimeString:attributes[@"created_at"]];
  order.credit = [attributes monetaryValueForKey:@"credit"];
  order.donation = [[LUDonationModelBuilder builder] buildModelFromJSON:attributes[@"donation"]];
  order.earn = [attributes monetaryValueForKey:@"earn"];
  order.interstitialAction = [[LUInterstitialActionModelBuilder builder] buildModelFromJSON:attributes[@"interstitial_action"]];
  order.location = [[LULocationModelBuilder builder] buildModelFromJSON:attributes[@"location"]];
  order.loyalty = [[LULoyaltyModelBuilder builder] buildModelFromJSON:attributes[@"loyalty"]];
  order.merchant = [[LUMerchantModelBuilder builder] buildModelFromJSON:attributes[@"merchant"]];
  order.orderID = [attributes numberForKey:@"id"];
  order.refundedAt = [attributes dateForKey:@"refunded_at"];
  order.spend = [attributes monetaryValueForKey:@"spend"];
  order.state = [attributes stringForKey:@"state"];
  order.tip = [attributes monetaryValueForKey:@"tip"];
  order.total = [attributes monetaryValueForKey:@"total"];

  return order;
}

@end
