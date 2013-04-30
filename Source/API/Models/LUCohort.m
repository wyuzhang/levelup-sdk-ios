#import "LUCohort.h"

@implementation LUCohort

#pragma mark - Creation

- (id)initWithCampaign:(LUCampaign *)campaign code:(NSString *)code
     cohortDescription:(NSString *)cohortDescription cohortID:(NSNumber *)cohortID
            cohortType:(NSString *)cohortType cohortURL:(NSURL *)cohortURL
             emailBody:(NSString *)emailBody messageForEmailSubject:(NSString *)messageForEmailSubject
     messageForTwitter:(NSString *)messageForTwitter {
  self = [super init];
  if (!self) return nil;

  _campaign = campaign;
  _code = code;
  _cohortDescription = cohortDescription;
  _cohortID = cohortID;
  _cohortType = cohortType;
  _cohortURL = cohortURL;
  _emailBody = emailBody;
  _messageForEmailSubject = messageForEmailSubject;
  _messageForTwitter = messageForTwitter;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"LUCohort [campaign=%@, code=%@, cohortDescription=%@, cohortType=%@, cohortURL=%@, emailBody=%@, ID=%@, messageForEmailSubject=%@, messageForTwitter=%@]",
          self.campaign, self.code, self.cohortDescription, self.cohortType, self.cohortURL, self.emailBody, self.cohortID,
          self.messageForEmailSubject, self.messageForTwitter];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUCohort [campaign=%@, code=%@, ID=%@]", self.campaign, self.code, self.cohortID];
}

@end
