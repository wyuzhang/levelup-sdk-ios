#import "LUCampaignJSONFactory.h"
#import "LUCohort.h"
#import "LUCohortJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCohortJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  LUCampaign *campaign = [[LUCampaignJSONFactory factory] fromJSONObject:attributes[@"campaign"]];
  NSString *code = [attributes lu_stringForKey:@"code"];
  NSString *cohortDescription = [attributes lu_stringForKey:@"description"];
  NSNumber *cohortID = [attributes lu_numberForKey:@"id"];
  NSString *cohortType = [attributes lu_stringForKey:@"cohort_type"];
  NSURL *cohortURL = [attributes lu_URLForKey:@"url"];
  NSString *emailBody = [attributes lu_stringForKey:@"email_body"];
  NSString *messageForEmailSubject = [attributes lu_stringForKey:@"message_for_email_subject"];
  NSString *messageForTwitter = [attributes lu_stringForKey:@"message_for_twitter"];

  return [[LUCohort alloc] initWithCampaign:campaign code:code cohortDescription:cohortDescription
                                   cohortID:cohortID cohortType:cohortType cohortURL:cohortURL
                                  emailBody:emailBody messageForEmailSubject:messageForEmailSubject
                          messageForTwitter:messageForTwitter];
}

- (NSString *)rootKey {
  return @"cohort";
}

@end
