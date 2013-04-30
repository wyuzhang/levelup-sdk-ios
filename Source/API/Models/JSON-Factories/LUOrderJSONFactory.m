#import "LUDonationJSONFactory.h"
#import "LUInterstitialActionJSONFactory.h"
#import "LULocationJSONFactory.h"
#import "LULoyaltyJSONFactory.h"
#import "LUMerchantJSONFactory.h"
#import "LUMonetaryValueJSONFactory.h"
#import "LUOrder.h"
#import "LUOrderJSONFactory.h"
#import "NSDate+StringFormats.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUOrderJSONFactory

#pragma mark - Public Methods

- (id)createFromAttributes:(NSDictionary *)attributes {
  LUMonetaryValue *balance = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"balance"]];
  BOOL closed = [attributes boolForKey:@"bundle_closed"];
  NSDate *createdDate = [NSDate dateFromIso8601DateTimeString:attributes[@"created_at"]];
  LUMonetaryValue *credit = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"credit"]];
  LUDonation *donation = [[LUDonationJSONFactory factory] fromJSONObject:attributes[@"donation"]];
  LUMonetaryValue *earn = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"earn"]];
  LUInterstitialAction *interstitialAction = [[LUInterstitialActionJSONFactory factory] fromJSONObject:attributes[@"interstitial_action"]];
  LULocation *location = [[LULocationJSONFactory factory] fromJSONObject:attributes[@"location"]];
  LULoyalty *loyalty = [[LULoyaltyJSONFactory factory] fromJSONObject:attributes[@"loyalty"]];
  LUMerchant *merchant = [[LUMerchantJSONFactory factory] fromJSONObject:attributes[@"merchant"]];
  NSNumber *orderID = [attributes numberForKey:@"id"];
  NSDate *refundedDate = [attributes dateForKey:@"refunded_at"];
  LUMonetaryValue *spend = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"spend"]];
  LUOrderState state = [self stateFromString:[attributes stringForKey:@"state"]];
  LUMonetaryValue *tip = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"tip"]];
  LUMonetaryValue *total = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"total"]];

  return [[LUOrder alloc] initWithBalance:balance closed:closed createdDate:createdDate
                                   credit:credit donation:donation earn:earn
                       interstitialAction:interstitialAction location:location loyalty:loyalty
                                 merchant:merchant orderID:orderID refundedDate:refundedDate
                                    spend:spend state:state tip:tip total:total];
}

- (NSString *)rootKey {
  return @"order";
}

#pragma mark - Private Methods

- (LUOrderState)stateFromString:(NSString *)stateString {
  if ([stateString isEqualToString:@"completed"]) {
    return LUOrderCompleted;
  } else if ([stateString isEqualToString:@"processing"]) {
    return LUOrderProcessing;
  } else if ([stateString isEqualToString:@"refunded"]) {
    return LUOrderRefunded;
  } else {
    return LUOrderNoState;
  }
}

@end
