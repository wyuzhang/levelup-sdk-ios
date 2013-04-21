#import "LUCampaign.h"
#import "LUCohort.h"
#import "LUMonetaryValue.h"
#import "NSString+HTMLStripping.h"
#import <UIKit/UIKit.h>

NSString * const LUCohortTypeDefaultEmail = @"default_email";
NSString * const LUCohortTypeDefaultFacebook = @"default_facebook";
NSString * const LUCohortTypeDefaultTwitter = @"default_twitter";

@interface LUCampaign ()

@property (nonatomic, copy, readonly) NSURL *imageURL_1x;
@property (nonatomic, copy, readonly) NSURL *imageURL_2x;
@property (nonatomic, strong, readonly) LUCohort *referAFriendCohort;

@end

@implementation LUCampaign

#pragma mark - Creation

- (id)initWithCampaignID:(NSNumber *)campaignID claimed:(BOOL)claimed cohorts:(NSArray *)cohorts
        confirmationHTML:(NSString *)confirmationHTML global:(BOOL)global
             imageURL_1x:(NSURL *)imageURL_1x imageURL_2x:(NSURL *)imageURL_2x
               merchants:(NSArray *)merchants name:(NSString *)name offerHTML:(NSString *)offerHTML
      referAFriendCohort:(LUCohort *)referAFriendCohort sponsor:(NSString *)sponsor
            supportEmail:(NSString *)supportEmail value:(LUMonetaryValue *)value {
  self = [super init];
  if (!self) return nil;

  _campaignID = campaignID;
  _claimed = claimed;
  _cohorts = cohorts;
  _confirmationHTML = confirmationHTML;
  _global = global;
  _imageURL_1x = imageURL_1x;
  _imageURL_2x = imageURL_2x;
  _merchants = merchants;
  _name = name;
  _offerHTML = offerHTML;
  _referAFriendCohort = referAFriendCohort;
  _sponsor = sponsor;
  _supportEmail = supportEmail;
  _value = value;

  return self;
}


#pragma mark - Public Methods

- (NSString *)confirmationText {
  return [self.confirmationHTML stringByStrippingHTML];
}

- (NSURL *)imageURL {
  if ([UIScreen mainScreen].scale == 1.0f) {
    return self.imageURL_1x;
  } else {
    return self.imageURL_2x;
  }
}

- (NSString *)offerText {
  return [self.offerHTML stringByStrippingHTML];
}

- (NSString *)shareMessageForEmailBody {
  return [self sharingCohortOfType:LUCohortTypeDefaultEmail].emailBody;
}

- (NSString *)shareMessageForEmailSubject {
  return [self sharingCohortOfType:LUCohortTypeDefaultEmail].messageForEmailSubject;
}

- (NSString *)shareMessageForTwitter {
  return [self sharingCohortOfType:LUCohortTypeDefaultTwitter].messageForTwitter;
}

- (NSURL *)shareURLForEmail {
  return [self sharingCohortOfType:LUCohortTypeDefaultEmail].cohortURL;
}

- (NSURL *)shareURLForFacebook {
  return [self sharingCohortOfType:LUCohortTypeDefaultFacebook].cohortURL;
}

- (NSURL *)shareURLForTwitter {
  return [self sharingCohortOfType:LUCohortTypeDefaultTwitter].cohortURL;
}

- (NSString *)successfulClaimMessageHTML {
  if (self.confirmationHTML.length > 0) {
    return self.confirmationHTML;
  } else {
    return self.offerHTML;
  }
}

- (NSString *)successfulClaimMessageText {
  return [[self successfulClaimMessageHTML] stringByStrippingHTML];
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"LUCampaign [claimed=%@, cohorts=%@, confirmationHTML=%@, global=%@, ID=%@, imageURL_1x=%@, imageURL_2x=%@, merchants=%@, name=%@, offerHTML=%@, sponsor=%@, supportEmail=%@, value=%@]",
          @(self.claimed), self.cohorts, self.confirmationHTML, @(self.global), self.campaignID,
          self.imageURL_1x, self.imageURL_2x, self.merchants, self.name, self.offerHTML,
          self.sponsor, self.supportEmail, self.value];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUCampaign [ID=%@, name=%@, value=%@]", self.campaignID,
          self.name, self.value];
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

- (LUCohort *)sharingCohortOfType:(NSString *)type {
  if (self.referAFriendCohort) {
    return self.referAFriendCohort;
  }

  return [self firstCohortOfType:type];
}

@end
