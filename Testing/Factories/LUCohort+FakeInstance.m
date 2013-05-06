#import "LUCohort+FakeInstance.h"

@implementation LUCohort (FakeInstance)

+ (LUCohort *)fakeInstance {
  return [[LUCohort alloc] initWithCampaign:nil code:@"abcdef" cohortDescription:nil cohortID:@1 cohortType:nil
                                  cohortURL:nil emailBody:nil messageForEmailSubject:nil messageForTwitter:nil];
}

+ (LUCohort *)fakeInstanceForEmail {
  LUCohort *cohort = [self fakeInstance];
  [cohort setValue:@"default_email" forKey:@"cohortType"];
  [cohort setValue:[NSURL URLWithString:@"http://example.com/email_cohort"] forKey:@"cohortURL"];
  [cohort setValue:@"email body" forKey:@"emailBody"];
  [cohort setValue:@"email subject" forKey:@"messageForEmailSubject"];
  return cohort;
}

+ (LUCohort *)fakeInstanceForFacebook {
  LUCohort *cohort = [self fakeInstance];
  [cohort setValue:@"default_facebook" forKey:@"cohortType"];
  [cohort setValue:[NSURL URLWithString:@"http://example.com/facebook_cohort"] forKey:@"cohortURL"];
  return cohort;
}

+ (LUCohort *)fakeInstanceForReferAFriend {
  LUCohort *cohort = [self fakeInstance];
  [cohort setValue:@"refer_a_friend" forKey:@"cohortType"];
  [cohort setValue:[NSURL URLWithString:@"http://example.com/referAFriend"] forKey:@"cohortURL"];
  [cohort setValue:@"Refer-A-Friend email body" forKey:@"emailBody"];
  [cohort setValue:@"Refer-A-Friend email subject" forKey:@"messageForEmailSubject"];
  [cohort setValue:@"Refer-A-Friend twitter message" forKey:@"messageForTwitter"];
  return cohort;
}

+ (LUCohort *)fakeInstanceForTwitter {
  LUCohort *cohort = [self fakeInstance];
  [cohort setValue:@"default_twitter" forKey:@"cohortType"];
  [cohort setValue:[NSURL URLWithString:@"http://example.com/twitter_cohort"] forKey:@"cohortURL"];
  [cohort setValue:@"twitter message" forKey:@"messageForTwitter"];
  return cohort;
}

+ (NSArray *)fakeInstancesForAllAvailableCohorts {
  return @[[self fakeInstanceForEmail], [self fakeInstanceForFacebook], [self fakeInstanceForTwitter]];
}

@end
