#import "LUCampaign.h"
#import "LUCohort.h"
#import "LUMonetaryValue.h"
#import "NSString+HTMLStripping.h"
#import <UIKit/UIKit.h>

#define kCohortTypeDefaultEmail @"default_email"
#define kCohortTypeDefaultFacebook @"default_facebook"
#define kCohortTypeDefaultTwitter @"default_twitter"

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


- (BOOL)isClaimed {
  return [self.claimed boolValue];
}

- (BOOL)isGlobal {
  return [self.global boolValue] || nil == self.merchants || self.merchants.count == 0;
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

- (NSString *)unlockedString {
  if ([self isGlobal]) {
    return [NSString stringWithFormat:@"You've got %@ that you can use anywhere on LevelUp.",
            [self.value formattedAmountWithSymbol]];
  } else {
    return [NSString stringWithFormat:@"You've got %@ from %@.",
            [self.value formattedAmountWithSymbol], self.sponsor];
  }
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
