#import "LUCohort.h"

@implementation LUCohort

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"Cohort [campaign=%@, code=%@, cohortDescription=%@, cohortType=%@, emailBody=%@, ID=%@, messageForEmailSubject=%@, messageForTwitter=%@, url=%@]",
          self.campaign, self.code, self.cohortDescription, self.cohortType, self.emailBody, self.cohortID,
          self.messageForEmailSubject, self.messageForTwitter, self.url];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"Cohort [campaign=%@, code=%@, ID=%@]", self.campaign, self.code, self.cohortID];
}

@end
