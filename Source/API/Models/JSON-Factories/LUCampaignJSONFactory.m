#import "LUCampaign.h"
#import "LUCampaignJSONFactory.h"
#import "LUCohortJSONFactory.h"
#import "LUMerchantJSONFactory.h"
#import "LUMonetaryValueJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCampaignJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSNumber *campaignID = [attributes numberForKey:@"id"];
  BOOL claimed = [attributes boolForKey:@"claimed"];
  NSArray *cohorts = [[LUCohortJSONFactory factory] fromJSONObject:attributes[@"cohorts"]];
  NSString *confirmationHTML = [attributes stringForKey:@"confirmation_html"];
  NSURL *imageURL_1x = [attributes URLForKey:@"mobile_image_url_320x212_1x"];
  NSURL *imageURL_2x = [attributes URLForKey:@"mobile_image_url_320x212_2x"];
  NSArray *merchants = [[LUMerchantJSONFactory factory] fromJSONObject:attributes[@"merchants"]];
  BOOL global = merchants.count == 0 && [attributes boolForKey:@"global"];
  NSString *name = [attributes stringForKey:@"name"];
  NSString *offerHTML = [attributes stringForKey:@"offer_html"];
  LUCohort *referAFriendCohort = [[LUCohortJSONFactory factory] fromJSONObject:attributes[@"cohort"]];
  NSString *sponsor = [attributes stringForKey:@"sponsor"];
  NSString *supportEmail = [attributes stringForKey:@"support_email"];
  LUMonetaryValue *value = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"value"]];

  return [[LUCampaign alloc] initWithCampaignID:campaignID claimed:claimed cohorts:cohorts
                               confirmationHTML:confirmationHTML global:global
                                    imageURL_1x:imageURL_1x imageURL_2x:imageURL_2x
                                      merchants:merchants name:name offerHTML:offerHTML
                             referAFriendCohort:referAFriendCohort sponsor:sponsor
                                   supportEmail:supportEmail value:value];
}

- (NSString *)rootKey {
  return @"campaign";
}

@end
