#import "LUCampaignModelBuilder.h"
#import "LUCohort.h"
#import "LUCohortModelBuilder.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCohortModelBuilder

- (id)buildModelFromAttributes:(NSDictionary *)attributes {
  if (attributes[@"cohort"]) {
    attributes = attributes[@"cohort"];
  }

  LUCohort *cohort = [[LUCohort alloc] init];
  cohort.campaign = [[LUCampaignModelBuilder builder] buildModelFromJSON:attributes[@"campaign"]];
  cohort.code = [attributes stringForKey:@"code"];
  cohort.cohortDescription = [attributes stringForKey:@"description"];
  cohort.cohortID = [attributes numberForKey:@"id"];
  cohort.cohortType = [attributes stringForKey:@"cohort_type"];
  cohort.emailBody = [attributes stringForKey:@"email_body"];
  cohort.messageForEmailSubject = [attributes stringForKey:@"message_for_email_subject"];
  cohort.messageForTwitter = [attributes stringForKey:@"message_for_twitter"];
  cohort.url = [attributes stringForKey:@"url"];

  return cohort;
}

@end
