#import "LUCampaignJSONFactory.h"
#import "LUInterstitialAction.h"
#import "LUInterstitialActionJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUInterstitialActionJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  LUCampaign *campaign = [[LUCampaignJSONFactory factory] fromDictionary:attributes[@"campaign"]];
  NSNumber *interstitialActionID = [attributes lu_numberForKey:@"id"];
  LUInterstitialActionType type = [self typeFromString:[attributes lu_stringForKey:@"type"]];

  return [[LUInterstitialAction alloc] initWithCampaign:campaign interstitialActionID:interstitialActionID type:type];
}

- (NSString *)rootKey {
  return @"interstitial_action";
}

#pragma mark - Private Methods

- (LUInterstitialActionType)typeFromString:(NSString *)stateString {
  if ([stateString isEqualToString:@"customer_acquisition_share"]) {
    return LUInterstitialActionTypeCustomerAcquisitionShare;
  } else if ([stateString isEqualToString:@"email_capture_claim"]) {
    return LUInterstitialActionTypeEmailCaptureClaim;
  } else {
    return LUInterstitialActionTypeNone;
  }
}

@end
