#import "LUCohort+Fixtures.h"
#import "LUCohortJSONFactory.h"

@implementation LUCohort (Fixtures)

+ (LUCohort *)fullCohort {
  return [[LUCohortJSONFactory factory] fromJSONObject:[self fullJSONObject]];
}

+ (NSDictionary *)fullJSONObject {
  return @{
    @"campaign" : [LUCampaign minimalJSONObject],
    @"code" : @"code",
    @"cohort_type" : @"type",
    @"description" : @"description",
    @"email_body" : @"email body",
    @"id" : @1,
    @"message_for_email_subject" : @"email subject",
    @"message_for_twitter" : @"twitter message",
    @"url" : @"http://example.com"
  };
}

+ (LUCohort *)minimalCohort {
  return [[LUCohortJSONFactory factory] fromJSONObject:[self minimalJSONObject]];
}

+ (NSDictionary *)minimalJSONObject {
  return @{
    @"id" : @1
  };
}

@end
