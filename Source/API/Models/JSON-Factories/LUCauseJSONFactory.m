#import "LUCause.h"
#import "LUCauseJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCauseJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSNumber *causeID = [attributes numberForKey:@"id"];
  NSString *descriptionHTML = [attributes stringForKey:@"description_html"];
  BOOL employerRequired = [attributes boolForKey:@"employer_required"];
  NSURL *facebookURL = [attributes URLForKey:@"facebook_url"];
  BOOL featured = [attributes boolForKey:@"featured"];
  BOOL homeAddressRequired = [attributes boolForKey:@"home_address_required"];
  NSURL *imageURL_1x = [attributes URLForKey:@"image_url_320x212_1x"];
  NSURL *imageURL_2x = [attributes URLForKey:@"image_url_320x212_2x"];
  NSNumber *minimumAgeRequired = [attributes numberForKey:@"minimum_age_required"];
  NSString *name = [attributes stringForKey:@"name"];
  NSString *partnerSpecificTerms = [attributes stringForKey:@"partner_specific_terms"];
  NSString *twitterUsername = [attributes stringForKey:@"twitter_username"];
  NSURL *websiteURL = [attributes URLForKey:@"website"];

  return [[LUCause alloc] initWithCauseID:causeID descriptionHTML:descriptionHTML
                         employerRequired:employerRequired facebookURL:facebookURL featured:featured
                      homeAddressRequired:homeAddressRequired imageURL_1x:imageURL_1x
                              imageURL_2x:imageURL_2x minimumAgeRequired:minimumAgeRequired
          name:name partnerSpecificTerms:partnerSpecificTerms twitterUsername:twitterUsername
                               websiteURL:websiteURL];
}

- (NSString *)rootKey {
  return @"cause";
}

@end
