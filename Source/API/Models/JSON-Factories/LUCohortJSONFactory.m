#import "LUCampaignJSONFactory.h"
#import "LUCohort.h"
#import "LUCohortJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCohortJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  LUCampaign *campaign = [[LUCampaignJSONFactory factory] fromJSONObject:attributes[@"campaign"]];
  NSString *code = [attributes stringForKey:@"code"];
  NSString *cohortDescription = [attributes stringForKey:@"description"];
  NSNumber *cohortID = [attributes numberForKey:@"id"];
  NSString *cohortType = [attributes stringForKey:@"cohort_type"];
  NSURL *cohortURL = [attributes URLForKey:@"url"];
  NSString *emailBody = [attributes stringForKey:@"email_body"];
  NSString *messageForEmailSubject = [attributes stringForKey:@"message_for_email_subject"];
  NSString *messageForTwitter = [attributes stringForKey:@"message_for_twitter"];

  return [[LUCohort alloc] initWithCampaign:campaign code:code cohortDescription:cohortDescription
                                   cohortID:cohortID cohortType:cohortType cohortURL:cohortURL
                                  emailBody:emailBody messageForEmailSubject:messageForEmailSubject
                          messageForTwitter:messageForTwitter];
}

- (NSString *)rootKey {
  return @"cohort";
}

@end
