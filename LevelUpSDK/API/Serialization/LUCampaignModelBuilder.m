#import "LUCampaign.h"
#import "LUCampaignModelBuilder.h"
#import "LUCohortModelBuilder.h"
#import "LUMerchantModelBuilder.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCampaignModelBuilder

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  if (attributes[@"campaign"]) {
    attributes = attributes[@"campaign"];
  }

  LUCampaign *campaign = [[LUCampaign alloc] init];
  campaign.campaignID = [attributes numberForKey:@"id"];
  campaign.claimed = [attributes boolForKey:@"claimed"];
  campaign.cohort = [[LUCohortModelBuilder builder] buildModelFromJSON:attributes[@"cohort"]];
  campaign.cohorts = [[LUCohortModelBuilder builder] buildModelFromJSON:attributes[@"cohorts"]];
  campaign.confirmationHtml = [attributes stringForKey:@"confirmation_html"];
  campaign.merchants = [[LUMerchantModelBuilder builder] buildModelFromJSON:attributes[@"merchants"]];
  campaign.global = campaign.merchants.count == 0 && [attributes boolForKey:@"global"];
  campaign.name = [attributes stringForKey:@"name"];
  campaign.offerHtml = [attributes stringForKey:@"offer_html"];
  campaign.sponsor = [attributes stringForKey:@"sponsor"];
  campaign.supportEmail = [attributes stringForKey:@"support_email"];
  campaign.value = [attributes monetaryValueForKey:@"value"];

  return campaign;
}

@end
