#import "LULocationJSONFactory.h"
#import "LULoyaltyJSONFactory.h"
#import "LUMerchant.h"
#import "LUMerchantJSONFactory.h"
#import "LUMonetaryValueJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUMerchantJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *descriptionHTML = [attributes lu_stringForKey:@"description_html"];
  LUMonetaryValue *earn = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"earn"]];
  NSURL *facebookURL = [attributes lu_URLForKey:@"facebook_url"];
  BOOL featured = [attributes lu_boolForKey:@"featured"];
  NSURL *imageURL_1x = [attributes lu_URLForKey:@"image_url_280x128_1x"];
  NSURL *imageURL_2x = [attributes lu_URLForKey:@"image_url_280x128_2x"];
  NSArray *locations = [[LULocationJSONFactory factory] fromJSONObject:attributes[@"locations"]];
  NSNumber *merchantID = [attributes lu_numberForKey:@"id"];
  NSString *name = [attributes lu_stringForKey:@"name"];
  NSURL *newsletterURL = [attributes lu_URLForKey:@"newsletter_url"];
  NSURL *opentableURL = [attributes lu_URLForKey:@"opentable_url"];
  NSURL *publicURL = [attributes lu_URLForKey:@"public_url"];
  NSURL *scvngrURL = [attributes lu_URLForKey:@"scvngr_url"];
  LUMonetaryValue *spend = [[LUMonetaryValueJSONFactory factory] fromJSONObject:attributes[@"spend"]];
  NSString *twitterUsername = [attributes lu_stringForKey:@"twitter_username"];
  NSURL *websiteURL = [attributes lu_URLForKey:@"url"];
  NSURL *yelpURL = [attributes lu_URLForKey:@"yelp_url"];

  LULoyaltyJSONFactory *loyaltyJSONFactory = [LULoyaltyJSONFactory factory];
  loyaltyJSONFactory.loyaltyEnabled = [attributes lu_boolForKey:@"loyalty_enabled"];
  LULoyalty *loyalty = [loyaltyJSONFactory fromJSONObject:attributes[@"loyalty"]];

  return [[LUMerchant alloc] initWithDescriptionHTML:descriptionHTML earn:earn facebookURL:facebookURL featured:featured
                                         imageURL_1x:imageURL_1x imageURL_2x:imageURL_2x locations:locations loyalty:loyalty
                                          merchantID:merchantID name:name
                                       newsletterURL:newsletterURL opentableURL:opentableURL
                                           publicURL:publicURL scvngrURL:scvngrURL spend:spend
                                     twitterUsername:twitterUsername yelpURL:yelpURL
                                          websiteURL:websiteURL];
}

- (NSString *)rootKey {
  return @"merchant";
}

@end
