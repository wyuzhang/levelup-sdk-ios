#import "LUCohortJSONFactory.h"
#import "LULocationJSONFactory.h"
#import "LULoyaltyJSONFactory.h"
#import "LUMerchant.h"
#import "LUMerchantJSONFactory.h"
#import "LUMonetaryValueJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUMerchantJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *descriptionHTML = [attributes stringForKey:@"description_html"];
  LUMonetaryValue *earn = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"earn"]];
  LUCohort *emailCaptureCohort = [[LUCohortJSONFactory factory] fromJSONObject:attributes[@"email_capture_cohort"]];
  NSURL *facebookURL = [attributes URLForKey:@"facebook_url"];
  BOOL featured = [attributes boolForKey:@"featured"];
  NSURL *imageURL_1x = [attributes URLForKey:@"image_url_280x128_1x"];
  NSURL *imageURL_2x = [attributes URLForKey:@"image_url_280x128_2x"];
  NSArray *locations = [[LULocationJSONFactory factory] fromJSONObject:attributes[@"locations"]];
  LULoyalty *loyalty = [[LULoyaltyJSONFactory factory] fromJSONObject:attributes[@"loyalty"]];
  BOOL loyaltyEnabled = [attributes boolForKey:@"loyalty_enabled"];
  NSNumber *merchantID = [attributes numberForKey:@"id"];
  NSString *name = [attributes stringForKey:@"name"];
  NSURL *newsletterURL = [attributes URLForKey:@"newsletter_url"];
  NSURL *opentableURL = [attributes URLForKey:@"opentable_url"];
  NSURL *publicURL = [attributes URLForKey:@"public_url"];
  NSURL *scvngrURL = [attributes URLForKey:@"scvngr_url"];
  LUMonetaryValue *spend = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"spend"]];
  NSString *twitterUsername = [attributes stringForKey:@"twitter_username"];
  NSURL *websiteURL = [attributes URLForKey:@"url"];
  NSURL *yelpURL = [attributes URLForKey:@"yelp_url"];

  return [[LUMerchant alloc] initWithDescriptionHTML:descriptionHTML earn:earn
                                  emailCaptureCohort:emailCaptureCohort facebookURL:facebookURL
                                            featured:featured imageURL_1x:imageURL_1x
                                         imageURL_2x:imageURL_2x locations:locations loyalty:loyalty
                                      loyaltyEnabled:loyaltyEnabled merchantID:merchantID
                                                name:name newsletterURL:newsletterURL
                                        opentableURL:opentableURL publicURL:publicURL
                                           scvngrURL:scvngrURL spend:spend
                                     twitterUsername:twitterUsername yelpURL:yelpURL
                                          websiteURL:websiteURL];
}

- (NSString *)rootKey {
  return @"merchant";
}

@end
