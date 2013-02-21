#import "LUCause.h"
#import <UIKit/UIKit.h>

@interface LUCause ()

@property (nonatomic, copy) NSString *imageUrl_320x212_1x;
@property (nonatomic, copy) NSString *imageUrl_320x212_2x;

@end

@implementation LUCause

#pragma mark - Public Methods

- (BOOL)anyUserRequirements {
  return self.employerRequired || self.homeAddressRequired || [self hasMinimumAgeRequired] || [self hasPartnerSpecificTerms];
}

- (BOOL)hasMinimumAgeRequired {
  return self.minimumAgeRequired && self.minimumAgeRequired.integerValue > 0;
}

- (BOOL)hasPartnerSpecificTerms {
  return self.partnerSpecificTerms && self.partnerSpecificTerms.length > 0;
}

- (NSString *)imageUrl {
  return [self valueForKey:[NSString stringWithFormat:@"imageUrl_320x212_%dx", (int)[UIScreen mainScreen].scale]];
}

- (NSString *)twitterUrl {
  NSString *twitterUrl;

  if (self.twitterUsername && self.twitterUsername.length > 0) {
    twitterUrl = [@"http://twitter.com/" stringByAppendingString:self.twitterUsername];
  } else {
    twitterUrl = nil;
  }

  return twitterUrl;
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"Cause [descriptionHtml=%@, employerRequired=%@, facebookUrl=%@, featured=%@, homeAddressRequired=%@, ID=%@, imageUrl_320x212_1x=%@, imageUrl_320x212_2x=%@, minimumAgeRequired=%@, name=%@, partnerSpecificTerms=%@, twitterUsername=%@, website=%@]",
          self.descriptionHtml, @(self.employerRequired), self.facebookUrl, @(self.featured), @(self.homeAddressRequired),
          self.causeID, self.imageUrl_320x212_1x, self.imageUrl_320x212_2x, self.minimumAgeRequired, self.name,
          self.partnerSpecificTerms, self.twitterUsername, self.website];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"Cause [ID=%@, name=%@]", self.causeID, self.name];
}

@end
