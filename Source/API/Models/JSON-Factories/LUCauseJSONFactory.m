#import "LUCause.h"
#import "LUCauseJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCauseJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSNumber *causeID = [attributes lu_numberForKey:@"id"];
  NSString *descriptionHTML = [attributes lu_stringForKey:@"description_html"];
  BOOL employerRequired = [attributes lu_boolForKey:@"employer_required"];
  NSURL *facebookURL = [attributes lu_URLForKey:@"facebook_url"];
  BOOL featured = [attributes lu_boolForKey:@"featured"];
  BOOL homeAddressRequired = [attributes lu_boolForKey:@"home_address_required"];
  NSURL *imageURL_1x = [attributes lu_URLForKey:@"image_url_320x212_1x"];
  NSURL *imageURL_2x = [attributes lu_URLForKey:@"image_url_320x212_2x"];
  NSNumber *minimumAgeRequired = [attributes lu_numberForKey:@"minimum_age_required"];
  NSString *name = [attributes lu_stringForKey:@"name"];
  NSString *partnerSpecificTerms = [attributes lu_stringForKey:@"partner_specific_terms"];
  NSString *twitterUsername = [attributes lu_stringForKey:@"twitter_username"];
  NSURL *websiteURL = [attributes lu_URLForKey:@"website"];

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
