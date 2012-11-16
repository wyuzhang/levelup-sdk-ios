#import "LUCause.h"
#import "LUJSONDeserializer.h"
#import "NSString+Escaping.h"
#import <UIKit/UIKit.h>

@implementation LUCause

#pragma mark -
#pragma mark Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"cause"];
  }
}

#pragma mark -
#pragma mark Public Methods

- (BOOL)anyUserRequirements {
  return [self isEmployerRequired] || [self isHomeAddressRequired] || [self isMinimumAgeRequired] || [self hasPartnerSpecificTerms];
}

- (BOOL)hasPartnerSpecificTerms {
  return self.partnerSpecificTerms && self.partnerSpecificTerms.length > 0;
}

- (NSString *)imageUrl {
  return [self valueForKey:[NSString stringWithFormat:@"imageUrl_320x212_%dx", (int)[UIScreen mainScreen].scale]];
}

- (BOOL)isEmployerRequired {
  return [self.employerRequired boolValue];
}

- (BOOL)isFeatured {
  return [self.featured boolValue];
}

- (BOOL)isHomeAddressRequired {
  return [self.homeAddressRequired boolValue];
}

- (BOOL)isMinimumAgeRequired {
  return self.minimumAgeRequired != nil;
}

- (NSString *)searchNormalizedName {
  return [self.name searchNormalizedString];
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
