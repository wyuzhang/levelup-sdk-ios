#import "LUCohortModelBuilder.h"
#import "LULocationModelBuilder.h"
#import "LULoyaltyModelBuilder.h"
#import "LUMerchant.h"
#import "LUMerchantModelBuilder.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUMerchantModelBuilder

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  if (attributes[@"merchant"]) {
    attributes = attributes[@"merchant"];
  }

  LUMerchant *merchant = [[LUMerchant alloc] init];
  merchant.descriptionHtml = [attributes stringForKey:@"description_html"];
  merchant.earn = [attributes monetaryValueForKey:@"earn"];
  merchant.emailCaptureCohort = [[LUCohortModelBuilder builder] buildModelFromJSON:attributes[@"email_capture_cohort"]];
  merchant.facebookUrl = [attributes stringForKey:@"facebook_url"];
  merchant.featured = [attributes boolForKey:@"featured"];
  merchant.locations = [[LULocationModelBuilder builder] buildModelFromJSON:attributes[@"locations"]];
  merchant.loyalty = [[LULoyaltyModelBuilder builder] buildModelFromJSON:attributes[@"loyalty"]];
  merchant.loyaltyEnabled = [attributes boolForKey:@"loyalty_enabled"];
  merchant.merchantID = [attributes numberForKey:@"id"];
  merchant.name = [attributes stringForKey:@"name"];
  merchant.newsletterUrl = [attributes stringForKey:@"newsletter_url"];
  merchant.opentableUrl = [attributes stringForKey:@"opentable_url"];
  merchant.publicUrl = [attributes stringForKey:@"public_url"];
  merchant.scvngrUrl = [attributes stringForKey:@"scvngr_url"];
  merchant.spend = [attributes monetaryValueForKey:@"spend"];
  merchant.twitterUsername = [attributes stringForKey:@"twitter_username"];
  merchant.url = [attributes stringForKey:@"url"];
  merchant.yelpUrl = [attributes stringForKey:@"yelp_url"];

  return merchant;
}

@end
