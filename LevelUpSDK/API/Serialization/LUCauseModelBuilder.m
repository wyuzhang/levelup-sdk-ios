#import "LUCause.h"
#import "LUCauseModelBuilder.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCauseModelBuilder

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  if (attributes[@"cause"]) {
    attributes = attributes[@"cause"];
  }

  LUCause *cause = [[LUCause alloc] init];
  cause.causeID = [attributes numberForKey:@"id"];
  cause.descriptionHtml = [attributes stringForKey:@"description_html"];
  cause.employerRequired = [attributes boolForKey:@"employer_required"];
  cause.facebookUrl = [attributes stringForKey:@"facebook_url"];
  cause.featured = [attributes boolForKey:@"featured"];
  cause.homeAddressRequired = [attributes boolForKey:@"home_address_required"];
  cause.minimumAgeRequired = [attributes numberForKey:@"minimum_age_required"];
  cause.name = [attributes stringForKey:@"name"];
  cause.partnerSpecificTerms = [attributes stringForKey:@"partner_specific_terms"];
  cause.twitterUsername = [attributes stringForKey:@"twitter_username"];
  cause.website = [attributes stringForKey:@"website"];

  return cause;
}

@end
