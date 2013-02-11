#import "LUCause.h"
#import <UIKit/UIKit.h>

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

@end
