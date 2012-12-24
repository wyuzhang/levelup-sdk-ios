#import "LUCampaign.h"
#import "LUCohort.h"
#import "LUJSONDeserializer.h"
#import "LUMonetaryValue.h"
#import "NSString+HTMLStripping.h"
#import <UIKit/UIKit.h>

@implementation LUCampaign

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"campaign"];
  }
}

#define kCohortTypeDefaultEmail @"default_email"
#define kCohortTypeDefaultFacebook @"default_facebook"
#define kCohortTypeDefaultTwitter @"default_twitter"

#pragma mark - Public Methods

- (NSString *)confirmationText {
  return [self.confirmationHtml stringByStrippingHTML];
}

- (NSString *)creditInformation {
  return [NSString stringWithFormat:@"You've got %@ to spend at %@! That's in addition to any credit you might've already had.",
          [self.value shortFormatWithSymbol],
          self.merchants.count > 1 ? @"these places" : [(self.merchants)[0] name]];
}

- (LUCohort *)emailCohort {
  return [self firstCohortOfType:kCohortTypeDefaultEmail];
}

- (LUCohort *)facebookCohort {
  return [self firstCohortOfType:kCohortTypeDefaultFacebook];
}

- (NSString *)grabString {
  NSMutableString *grabString = [NSMutableString stringWithFormat:@"You scanned a LevelUp Code worth %@ to spend ",
                                 [self.value shortFormatWithSymbol]];

  if ([self isGlobal]) {
    [grabString appendString:@"anywhere on LevelUp. "];
  } else {
    if (self.merchants.count == 1) {
      [grabString appendFormat:@"at %@. ", [(self.merchants)[0] name]];
    } else if (self.merchants.count == 2) {
      [grabString appendFormat:@"at %@ or %@. ",
       [(self.merchants)[0] name],
       [(self.merchants)[1] name]];
    } else if (self.merchants.count == 3) {
      [grabString appendFormat:@"at %@, %@, or %@. ",
       [(self.merchants)[0] name],
       [(self.merchants)[1] name],
       [(self.merchants)[2] name]];
    } else {
      [grabString appendFormat:@"at %@, %@, %@, and more. ",
       [(self.merchants)[0] name],
       [(self.merchants)[1] name],
       [(self.merchants)[2] name]];
    }
  }

  [grabString appendString:
   @"But... before you can spend it you need to <strong>log in</strong> or <strong>join LevelUp</strong>. "
   @"LevelUp is an app that lets you pay with your phone all over town."];

  return grabString;
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

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.claimed) {
    total += [self.claimed intValue] * 11;
  }
  if (self.cohorts) {
    total += [self.cohorts hash] * 13;
  }
  if (self.confirmationHtml) {
    total += [self.confirmationHtml hash] * 17;
  }
  if (self.global) {
    total += [self.global intValue] * 19;
  }
  if (self.merchants) {
    total += [self.merchants hash] * 21;
  }
  if (self.mobileImageUrl_320x212_1x) {
    total += [self.mobileImageUrl_320x212_1x hash] * 23;
  }
  if (self.mobileImageUrl_320x212_2x) {
    total += [self.mobileImageUrl_320x212_2x intValue] * 29;
  }
  if (self.modelId) {
    total += [self.modelId intValue] * 31;
  }
  if (self.name) {
    total += [self.name hash] * 37;
  }
  if (self.offerHtml) {
    total += [self.offerHtml hash] * 41;
  }
  if (self.sponsor) {
    total += [self.sponsor hash] * 43;
  }
  if (self.supportEmail) {
    total += [self.supportEmail hash] * 47;
  }
  if (self.value) {
    total += [self.value hash] * 53;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUCampaign class]]) {
    LUCampaign *otherCampaign = (LUCampaign *)otherObject;

    BOOL claimedEqual = ((!otherCampaign.claimed && !self.claimed) ||
        (otherCampaign.claimed && self.claimed &&
        [otherCampaign.claimed intValue] == [self.claimed intValue]));

    BOOL cohortsEqual = ((!otherCampaign.cohorts && !self.cohorts) ||
        (otherCampaign.cohorts && self.cohorts &&
        [otherCampaign.cohorts isEqualToArray:self.cohorts]));

    BOOL confirmationHtmlEqual = ((!otherCampaign.confirmationHtml && !self.confirmationHtml) ||
        (otherCampaign.confirmationHtml && self.confirmationHtml &&
        [otherCampaign.confirmationHtml isEqualToString:self.confirmationHtml]));

    BOOL globalEqual = ((!otherCampaign.global && !self.global) ||
        (otherCampaign.global && self.global &&
        [otherCampaign.global intValue] == [self.global intValue]));

    BOOL merchantsEqual = ((!otherCampaign.merchants && !self.merchants) ||
        (otherCampaign.merchants && self.merchants &&
        [otherCampaign.merchants isEqualToArray:self.merchants]));

    BOOL mobileImageUrl_1Equal = ((!otherCampaign.mobileImageUrl_320x212_1x && !self.mobileImageUrl_320x212_1x) ||
        (otherCampaign.mobileImageUrl_320x212_1x && self.mobileImageUrl_320x212_1x &&
        [otherCampaign.mobileImageUrl_320x212_1x isEqualToString:self.mobileImageUrl_320x212_1x]));

    BOOL mobileImageUrl_2Equal = ((!otherCampaign.mobileImageUrl_320x212_2x && !self.mobileImageUrl_320x212_2x) ||
        (otherCampaign.mobileImageUrl_320x212_2x && self.mobileImageUrl_320x212_2x &&
        [otherCampaign.mobileImageUrl_320x212_2x isEqualToString:self.mobileImageUrl_320x212_2x]));

    BOOL modelIdEqual = ((!otherCampaign.modelId && !self.modelId) ||
        (otherCampaign.modelId && self.modelId &&
        [otherCampaign.modelId intValue] == [self.modelId intValue]));

    BOOL nameEqual = ((!otherCampaign.name && !self.name) ||
        (otherCampaign.name && self.name &&
        [otherCampaign.name isEqualToString:self.name]));

    BOOL offerHtmlEqual = ((!otherCampaign.offerHtml && !self.offerHtml) ||
        (otherCampaign.offerHtml && self.offerHtml &&
        [otherCampaign.offerHtml isEqualToString:self.offerHtml]));

    BOOL sponsorEqual = ((!otherCampaign.sponsor && !self.sponsor) ||
        (otherCampaign.sponsor && self.sponsor &&
        [otherCampaign.sponsor isEqualToString:self.sponsor]));

    BOOL supportEmailEqual = ((!otherCampaign.supportEmail && !self.supportEmail) ||
        (otherCampaign.supportEmail && self.supportEmail &&
        [otherCampaign.supportEmail isEqualToString:self.supportEmail]));

    BOOL valueEqual = ((!otherCampaign.value && !self.value) ||
        (otherCampaign.value && self.value &&
        [otherCampaign.value isEqual:self.value]));

    return claimedEqual && cohortsEqual && confirmationHtmlEqual && globalEqual && merchantsEqual &&
        mobileImageUrl_1Equal && mobileImageUrl_2Equal && modelIdEqual && nameEqual &&
        offerHtmlEqual && sponsorEqual && supportEmailEqual && valueEqual;
  }

  return NO;
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
