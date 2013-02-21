#import "LUCampaignModelBuilder.h"
#import "LUInterstitialAction.h"
#import "LUInterstitialActionModelBuilder.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUInterstitialActionModelBuilder

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  if (attributes[@"interstitial_action"]) {
    attributes = attributes[@"interstitial_action"];
  }

  LUInterstitialAction *interstitialAction = [[LUInterstitialAction alloc] init];
  interstitialAction.campaign = [[LUCampaignModelBuilder builder] buildModelFromAttributes:attributes[@"campaign"]];
  interstitialAction.interstitialActionID = [attributes numberForKey:@"id"];
  interstitialAction.type = [attributes stringForKey:@"type"];

  return interstitialAction;
}

@end
