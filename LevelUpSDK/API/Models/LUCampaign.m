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
