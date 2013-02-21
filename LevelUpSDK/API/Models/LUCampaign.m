#import "LUCampaign.h"
#import "LUCohort.h"
#import "LUMonetaryValue.h"
#import "NSString+HTMLStripping.h"
#import <UIKit/UIKit.h>

#define kCohortTypeDefaultEmail @"default_email"
#define kCohortTypeDefaultFacebook @"default_facebook"
#define kCohortTypeDefaultTwitter @"default_twitter"

@interface LUCampaign ()

@property (nonatomic, copy) NSString *mobileImageUrl_320x212_1x;
@property (nonatomic, copy) NSString *mobileImageUrl_320x212_2x;

@end

@implementation LUCampaign

#pragma mark - Public Methods

- (NSString *)confirmationText {
  return [self.confirmationHtml stringByStrippingHTML];
}

- (LUCohort *)emailCohort {
  return [self firstCohortOfType:kCohortTypeDefaultEmail];
}

- (LUCohort *)facebookCohort {
  return [self firstCohortOfType:kCohortTypeDefaultFacebook];
}

- (BOOL)isGlobal {
  return self.global || nil == self.merchants || self.merchants.count == 0;
}

- (NSString *)mobileImageUrl {
  return [self valueForKey:[NSString stringWithFormat:@"mobileImageUrl_320x212_%dx", (int)[UIScreen mainScreen].scale]];
}

- (NSString *)offerText {
  return [self.offerHtml stringByStrippingHTML];
}

- (NSString *)successfulClaimMessageHtml {
  if (self.confirmationHtml.length > 0) {
    return self.confirmationHtml;
  } else {
    return self.offerHtml;
  }
}

- (NSString *)successfulClaimMessageText {
  return [[self successfulClaimMessageHtml] stringByStrippingHTML];
}

- (LUCohort *)twitterCohort {
  return [self firstCohortOfType:kCohortTypeDefaultTwitter];
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"Campaign [claimed=%@, cohort=%@, cohorts=%@, confirmationHtml=%@, global=%@, ID=%@, merchants=%@, mobileImageUrl_320x212_1x=%@, mobileImageUrl_320x212_2x=%@, name=%@, offerHtml=%@, sponsor=%@, supportEmail=%@, value=%@]",
          @(self.claimed), self.cohort, self.cohorts, self.confirmationHtml, @(self.global), self.campaignID,
          self.mobileImageUrl_320x212_1x, self.mobileImageUrl_320x212_2x, self.merchants, self.name, self.offerHtml,
          self.sponsor, self.supportEmail, self.value];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"Campaign [ID=%@, name=%@, value=%@]", self.campaignID, self.name, self.value];
}

#pragma mark - Private Methods

- (LUCohort *)firstCohortOfType:(NSString *)type {
  for (LUCohort *cohort in self.cohorts) {
    if ([cohort.cohortType isEqualToString:type]) {
      return cohort;
    }
  }

  return nil;
}

@end
