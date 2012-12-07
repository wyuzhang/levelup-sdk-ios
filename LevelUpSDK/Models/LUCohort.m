#import "LUCampaign.h"
#import "LUCohort.h"
#import "LUJSONDeserializer.h"

@implementation LUCohort

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifiers:@[@"cohort", @"email_capture_cohort", @"share_cohort"]];
  }
}

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.campaign) {
    total += [self.campaign.modelId intValue] * 11;
  }
  if (self.code) {
    total += [self.code hash] * 13;
  }
  if (self.cohortType) {
    total += [self.cohortType hash] * 17;
  }
  if (self.description) {
    total += [self.description hash] * 19;
  }
  if (self.emailBody) {
    total += [self.emailBody hash] * 23;
  }
  if (self.messageForEmailSubject) {
    total += [self.messageForEmailSubject hash] * 29;
  }
  if (self.messageForTwitter) {
    total += [self.messageForTwitter hash] * 31;
  }
  if (self.modelId) {
    total += [self.modelId intValue] * 37;
  }
  if (self.url) {
    total += [self.url hash] * 41;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUCohort class]]) {
    LUCohort *otherCohort = (LUCohort *)otherObject;

    BOOL campaignEqual = ((!otherCohort.campaign.modelId && !self.campaign.modelId) ||
        (otherCohort.campaign.modelId && self.campaign.modelId &&
        [otherCohort.campaign.modelId intValue] == [self.campaign.modelId intValue]));

    BOOL codeEqual = ((!otherCohort.code && !self.code) ||
        (otherCohort.code && self.code &&
        [otherCohort.code isEqualToString:self.code]));

    BOOL cohortTypeEqual = ((!otherCohort.cohortType && !self.cohortType) ||
        (otherCohort.cohortType && self.cohortType &&
        [otherCohort.cohortType isEqualToString:self.cohortType]));

    BOOL descriptionEqual = ((!otherCohort.description && !self.description) ||
        (otherCohort.description && self.description &&
        [otherCohort.description isEqualToString:self.description]));

    BOOL emailBodyEqual = ((!otherCohort.emailBody && !self.emailBody) ||
        (otherCohort.emailBody && self.emailBody &&
        [otherCohort.emailBody isEqualToString:self.emailBody]));

    BOOL messageForEmailSubjectEqual = ((!otherCohort.messageForEmailSubject && !self.messageForEmailSubject) ||
        (otherCohort.messageForEmailSubject && self.messageForEmailSubject &&
        [otherCohort.messageForEmailSubject isEqualToString:self.messageForEmailSubject]));

    BOOL messageForTwitterEqual = ((!otherCohort.messageForTwitter && !self.messageForTwitter) ||
        (otherCohort.messageForTwitter && self.messageForTwitter &&
        [otherCohort.messageForTwitter isEqualToString:self.messageForTwitter]));

    BOOL modelIdEqual = ((!otherCohort.modelId && !self.modelId) ||
        (otherCohort.modelId && self.modelId &&
        [otherCohort.modelId intValue] == [self.modelId intValue]));

    BOOL urlEqual = ((!otherCohort.url && !self.url) ||
        (otherCohort.url && self.url &&
        [otherCohort.url isEqualToString:self.url]));

    return campaignEqual && codeEqual && cohortTypeEqual && descriptionEqual &&
        emailBodyEqual && messageForEmailSubjectEqual && messageForTwitterEqual && modelIdEqual &&
        urlEqual;
  }

  return NO;
}

@end
