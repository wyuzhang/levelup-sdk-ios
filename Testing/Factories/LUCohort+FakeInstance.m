#import "LUCohort+FakeInstance.h"

@implementation LUCohort (FakeInstance)

+ (NSArray *)fakeInstancesForAllAvailableCohorts {
  return @[[self fakeInstanceForEmail], [self fakeInstanceForFacebook], [self fakeInstanceForTwitter]];
}

+ (LUCohort *)fakeInstanceForEmail {
  return [[LUCohort alloc] initWithCampaign:nil code:nil cohortDescription:nil cohortID:nil
                                 cohortType:@"default_email"
                                  cohortURL:[NSURL URLWithString:@"http://example.com/email_cohort"]
                                  emailBody:@"email body"
                     messageForEmailSubject:@"email subject"
                          messageForTwitter:nil];
}

+ (LUCohort *)fakeInstanceForFacebook {
  return [[LUCohort alloc] initWithCampaign:nil code:nil cohortDescription:nil cohortID:nil
                                 cohortType:@"default_facebook"
                                  cohortURL:[NSURL URLWithString:@"http://example.com/facebook_cohort"]
                                  emailBody:nil messageForEmailSubject:nil messageForTwitter:nil];
}

+ (LUCohort *)fakeInstanceForReferAFriend {
  return [[LUCohort alloc] initWithCampaign:nil code:nil cohortDescription:nil cohortID:nil
                                 cohortType:@"refer_a_friend"
                                  cohortURL:[NSURL URLWithString:@"http://example.com/referAFriend"]
                                  emailBody:@"Refer-A-Friend email body"
                     messageForEmailSubject:@"Refer-A-Friend email subject"
                          messageForTwitter:@"Refer-A-Friend twitter message"];
}

+ (LUCohort *)fakeInstanceForTwitter {
  return [[LUCohort alloc] initWithCampaign:nil code:nil cohortDescription:nil cohortID:nil
                                 cohortType:@"default_twitter"
                                  cohortURL:[NSURL URLWithString:@"http://example.com/twitter_cohort"]
                                  emailBody:nil messageForEmailSubject:nil
                          messageForTwitter:@"twitter message"];
}

@end
