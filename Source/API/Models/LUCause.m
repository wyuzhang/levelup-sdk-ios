#import "LUCause.h"
#import <UIKit/UIKit.h>

@interface LUCause ()

@property (nonatomic, copy, readonly) NSURL *imageURL_1x;
@property (nonatomic, copy, readonly) NSURL *imageURL_2x;

@end

@implementation LUCause

#pragma mark - Creation

- (id)initWithCauseID:(NSNumber *)causeID descriptionHTML:(NSString *)descriptionHTML
     employerRequired:(BOOL)employerRequired facebookURL:(NSURL *)facebookURL featured:(BOOL)featured
  homeAddressRequired:(BOOL)homeAddressRequired imageURL_1x:(NSURL *)imageURL_1x
          imageURL_2x:(NSURL *)imageURL_2x minimumAgeRequired:(NSNumber *)minimumAgeRequired
                 name:(NSString *)name partnerSpecificTerms:(NSString *)partnerSpecificTerms
      twitterUsername:(NSString *)twitterUsername websiteURL:(NSURL *)websiteURL {
  self = [super init];
  if (!self) return nil;

  _causeID = causeID;
  _descriptionHTML = descriptionHTML;
  _employerRequired = employerRequired;
  _facebookURL = facebookURL;
  _featured = featured;
  _homeAddressRequired = homeAddressRequired;
  _imageURL_1x = imageURL_1x;
  _imageURL_2x = imageURL_2x;
  _minimumAgeRequired = minimumAgeRequired;
  _name = name;
  _partnerSpecificTerms = partnerSpecificTerms;
  _twitterUsername = twitterUsername;
  _websiteURL = websiteURL;

  return self;
}


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

- (NSURL *)imageURL {
  if ([UIScreen mainScreen].scale == 1.0f) {
    return self.imageURL_1x;
  } else {
    return self.imageURL_2x;
  }
}

- (NSURL *)twitterURL {
  if (self.twitterUsername.length == 0) return nil;

  return [NSURL URLWithString:[@"http://twitter.com/" stringByAppendingString:self.twitterUsername]];
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"LUCause [descriptionHTML=%@, employerRequired=%@, facebookURL=%@, featured=%@, homeAddressRequired=%@, ID=%@, imageURL_1x=%@, imageURL_2x=%@, minimumAgeRequired=%@, name=%@, partnerSpecificTerms=%@, twitterUsername=%@, websiteURL=%@]",
          self.descriptionHTML, @(self.employerRequired), self.facebookURL, @(self.featured),
          @(self.homeAddressRequired), self.causeID, self.imageURL_1x, self.imageURL_2x,
          self.minimumAgeRequired, self.name, self.partnerSpecificTerms, self.twitterUsername,
          self.websiteURL];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUCause [ID=%@, name=%@]", self.causeID, self.name];
}

@end
