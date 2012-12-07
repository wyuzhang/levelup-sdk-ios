#import "LUCause.h"
#import "LUJSONDeserializer.h"
#import "NSString+Escaping.h"
#import <UIKit/UIKit.h>

@implementation LUCause

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"cause"];
  }
}

#pragma mark - Public Methods

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

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.descriptionHtml) {
    total += [self.descriptionHtml hash] * 11;
  }
  if (self.employerRequired) {
    total += [self.employerRequired intValue] * 13;
  }
  if (self.facebookUrl) {
    total += [self.facebookUrl hash] * 17;
  }
  if (self.featured) {
    total += [self.featured intValue] * 19;
  }
  if (self.homeAddressRequired) {
    total += [self.homeAddressRequired intValue] * 21;
  }
  if (self.imageUrl_320x212_1x) {
    total += [self.imageUrl_320x212_1x hash] * 23;
  }
  if (self.imageUrl_320x212_2x) {
    total += [self.imageUrl_320x212_2x hash] * 29;
  }
  if (self.minimumAgeRequired) {
    total += [self.minimumAgeRequired intValue] * 31;
  }
  if (self.modelId) {
    total += [self.modelId intValue] * 37;
  }
  if (self.name) {
    total += [self.name hash] * 41;
  }
  if (self.partnerSpecificTerms) {
    total += [self.partnerSpecificTerms hash] * 43;
  }
  if (self.searchNormalizedName) {
    total += [self.searchNormalizedName hash] * 47;
  }
  if (self.twitterUsername) {
    total += [self.twitterUsername hash] * 53;
  }
  if (self.website) {
    total += [self.website hash] * 57;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUCause class]]) {
    LUCause *otherCause = (LUCause *)otherObject;

    BOOL descriptionHtmlEqual = ((!otherCause.descriptionHtml && !self.descriptionHtml) ||
        (otherCause.descriptionHtml && self.descriptionHtml &&
        [otherCause.descriptionHtml isEqualToString:self.descriptionHtml]));

    BOOL employerRequiredEqual = ((!otherCause.employerRequired && !self.employerRequired) ||
        (otherCause.employerRequired && self.employerRequired &&
        [otherCause.employerRequired intValue] == [self.employerRequired intValue]));

    BOOL facebookUrlEqual = ((!otherCause.facebookUrl && !self.facebookUrl) ||
        (otherCause.facebookUrl && self.facebookUrl &&
        [otherCause.facebookUrl isEqualToString:self.facebookUrl]));

    BOOL featuredEqual = ((!otherCause.featured && !self.featured) ||
        (otherCause.featured && self.featured &&
        [otherCause.featured intValue] == [self.featured intValue]));

    BOOL homeAddressRequiredEqual = ((!otherCause.homeAddressRequired && !self.homeAddressRequired) ||
        (otherCause.homeAddressRequired && self.homeAddressRequired &&
        [otherCause.homeAddressRequired intValue] == [self.homeAddressRequired intValue]));

    BOOL imageUrl1Equal = ((!otherCause.imageUrl_320x212_1x && !self.imageUrl_320x212_1x) ||
        (otherCause.imageUrl_320x212_1x && self.imageUrl_320x212_1x &&
        [otherCause.imageUrl_320x212_1x isEqualToString:self.imageUrl_320x212_1x]));

    BOOL imageUrl2Equal = ((!otherCause.imageUrl_320x212_2x && !self.imageUrl_320x212_2x) ||
        (otherCause.imageUrl_320x212_2x && self.imageUrl_320x212_2x &&
        [otherCause.imageUrl_320x212_2x isEqualToString:self.imageUrl_320x212_2x]));

    BOOL minimumAgeRequiredEqual = ((!otherCause.minimumAgeRequired && !self.minimumAgeRequired) ||
        (otherCause.minimumAgeRequired && self.minimumAgeRequired &&
        [otherCause.minimumAgeRequired intValue] == [self.minimumAgeRequired intValue]));

    BOOL modelIdEqual = ((!otherCause.modelId && !self.modelId) ||
        (otherCause.modelId && self.modelId &&
        [otherCause.modelId intValue] == [self.modelId intValue]));

    BOOL nameEqual = ((!otherCause.name && !self.name) ||
        (otherCause.name && self.name &&
        [otherCause.name isEqualToString:self.name]));

    BOOL partnerSpecificTermsEqual = ((!otherCause.partnerSpecificTerms && !self.partnerSpecificTerms) ||
        (otherCause.partnerSpecificTerms && self.partnerSpecificTerms &&
        [otherCause.partnerSpecificTerms isEqualToString:self.partnerSpecificTerms]));

    BOOL searchNormalizedNameEqual = ((!otherCause.searchNormalizedName && !self.searchNormalizedName) ||
        (otherCause.searchNormalizedName && self.searchNormalizedName &&
        [otherCause.searchNormalizedName isEqualToString:self.searchNormalizedName]));

    BOOL twitterUsernameEqual = ((!otherCause.twitterUsername && !self.twitterUsername) ||
        (otherCause.twitterUsername && self.twitterUsername &&
        [otherCause.twitterUsername isEqualToString:self.twitterUsername]));

    BOOL websiteEqual = ((!otherCause.website && !self.website) ||
        (otherCause.website && self.website &&
        [otherCause.website isEqualToString:self.website]));

    return descriptionHtmlEqual && employerRequiredEqual && facebookUrlEqual && featuredEqual &&
      homeAddressRequiredEqual && imageUrl1Equal && imageUrl2Equal && minimumAgeRequiredEqual &&
      modelIdEqual && nameEqual && partnerSpecificTermsEqual && searchNormalizedNameEqual &&
      twitterUsernameEqual && websiteEqual;
  }

  return NO;
}


@end
