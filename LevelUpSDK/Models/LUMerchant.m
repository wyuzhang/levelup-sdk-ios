#import "LUCohort.h"
#import "LUJSONDeserializer.h"
#import "LULocation.h"
#import "LULoyalty.h"
#import "LUMerchant.h"
#import "LUMonetaryValue.h"
#import "LUUser.h"
#import "NSString+Escaping.h"

@implementation LUMerchant

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"merchant"];
  }
}

#pragma mark - Public Methods

- (LUMonetaryValue *)currentCredit {
  LUMonetaryValue *currentCredit;

  if (nil == self.loyalty) {
    currentCredit = [[LUMonetaryValue alloc] init];
    currentCredit.amount = @0;
    currentCredit.currencySymbol = @"$";
    currentCredit.formattedAmount = @"0.00";
  } else {
    currentCredit = self.loyalty.potentialCredit;
  }

  return currentCredit;
}

- (BOOL)isFeatured {
  return [self.featured boolValue];
}

- (NSString *)categoryImageUrl {
  return [self valueForKey:[NSString stringWithFormat:@"categoryImageUrl_32x32_%dx", (int)[UIScreen mainScreen].scale]];
}

- (NSString *)imageUrl {
  return [self valueForKey:[NSString stringWithFormat:@"imageUrl_280x128_%dx", (int)[UIScreen mainScreen].scale]];
}

- (BOOL)isLoyaltyEnabled {
  return [self.loyaltyEnabled boolValue];
}

- (LULocation *)locationNearestTo:(CLLocation *)location {
  NSArray *sortedLocations = [self.locations sortedArrayUsingComparator:^(id obj1, id obj2) {
    CLLocationDistance distance1 = [[obj1 location] distanceFromLocation:location];
    CLLocationDistance distance2 = [[obj2 location] distanceFromLocation:location];

    return [@(distance1) compare:@(distance2)];
  }];

  return sortedLocations[0];
}

- (LUMonetaryValue *)loyaltyAmountAvailable {
  if (nil != self.loyalty && nil != self.loyalty.potentialCredit &&
      [self.loyalty.potentialCredit.amount floatValue] > 0.0f) {
    return self.loyalty.potentialCredit;
  }

  return nil;
}

- (NSString *)searchNormalizedName {
  return [self.name searchNormalizedString];
}

- (NSString *)twitterUrl {
  NSString *twitterUrl;

  if (self.twitterUsername.length > 0) {
    twitterUrl = [@"http://twitter.com/" stringByAppendingString:self.twitterUsername];
  } else {
    twitterUrl = nil;
  }

  return twitterUrl;
}

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.categoryImageUrl_32x32_1x) {
    total += [self.categoryImageUrl_32x32_1x hash] * 11;
  }
  if (self.categoryImageUrl_32x32_2x) {
    total += [self.categoryImageUrl_32x32_2x hash] * 13;
  }
  if (self.description) {
    total += [self.description hash] * 17;
  }
  if (self.descriptionHtml) {
    total += [self.descriptionHtml hash] * 19;
  }
  if (self.earn) {
    total += [self.earn hash] * 23;
  }
  if (self.emailCaptureCohort) {
    total += [self.emailCaptureCohort hash] * 29;
  }
  if (self.facebookUrl) {
    total += [self.facebookUrl hash] * 31;
  }
  if (self.featured) {
    total += [self.featured intValue] * 37;
  }
  if (self.imageUrl_280x128_1x) {
    total += [self.imageUrl_280x128_1x hash] * 41;
  }
  if (self.imageUrl_280x128_2x) {
    total += [self.imageUrl_280x128_2x hash] * 43;
  }
  if (self.locations) {
    total += [self.locations hash] * 47;
  }
  if (self.loyalty) {
    total += [self.loyalty hash] * 53;
  }
  if (self.loyaltyEnabled) {
    total += [self.loyaltyEnabled intValue] * 59;
  }
  if (self.messageForTwitter) {
    total += [self.messageForTwitter hash] * 61;
  }
  if (self.modelId) {
    total += [self.modelId intValue] * 67;
  }
  if (self.name) {
    total += [self.name hash] * 71;
  }
  if (self.newsletterUrl) {
    total += [self.newsletterUrl hash] * 73;
  }
  if (self.onboarding) {
    total += [self.onboarding hash] * 79;
  }
  if (self.opentableUrl) {
    total += [self.opentableUrl hash] * 83;
  }
  if (self.publicUrl) {
    total += [self.publicUrl hash] * 89;
  }
  if (self.scvngrUrl) {
    total += [self.scvngrUrl hash] * 97;
  }
  if (self.searchNormalizedName) {
    total += [self.searchNormalizedName hash] * 11;
  }
  if (self.spend) {
    total += [self.spend hash] * 13;
  }
  if (self.twitterUsername) {
    total += [self.twitterUsername hash] * 17;
  }
  if (self.url) {
    total += [self.url hash] * 19;
  }
  if (self.yelpUrl) {
    total += [self.yelpUrl hash] * 23;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUMerchant class]]) {
    LUMerchant *otherMerchant = (LUMerchant *)otherObject;

    BOOL categoryImageUrl1Equal = ((!otherMerchant.categoryImageUrl_32x32_1x &&
        !self.categoryImageUrl_32x32_1x) ||
        (otherMerchant.categoryImageUrl_32x32_1x && self.categoryImageUrl_32x32_1x &&
        [otherMerchant.categoryImageUrl_32x32_1x isEqualToString:self.categoryImageUrl_32x32_1x]));

    BOOL categoryImageUrl2Equal = ((!otherMerchant.categoryImageUrl_32x32_2x &&
        !self.categoryImageUrl_32x32_2x) ||
        (otherMerchant.categoryImageUrl_32x32_2x && self.categoryImageUrl_32x32_2x &&
        [otherMerchant.categoryImageUrl_32x32_2x isEqualToString:self.categoryImageUrl_32x32_2x]));

    BOOL descriptionEqual = ((!otherMerchant.description && !self.description) ||
        (otherMerchant.description && self.description &&
        [otherMerchant.description isEqualToString:self.description]));

    BOOL descriptionHtmlEqual = ((!otherMerchant.descriptionHtml && !self.descriptionHtml) ||
        (otherMerchant.descriptionHtml && self.descriptionHtml &&
        [otherMerchant.descriptionHtml isEqualToString:self.descriptionHtml]));

    BOOL earnEqual = ((!otherMerchant.earn && !self.earn) ||
        (otherMerchant.earn && self.earn &&
        [otherMerchant.earn isEqual:self.earn]));

    BOOL emailCaptureCohortEqual = ((!otherMerchant.emailCaptureCohort && !self.emailCaptureCohort) ||
        (otherMerchant.emailCaptureCohort && self.emailCaptureCohort &&
        [otherMerchant.emailCaptureCohort isEqual:self.emailCaptureCohort]));

    BOOL facebookUrlEqual = ((!otherMerchant.facebookUrl && !self.facebookUrl) ||
        (otherMerchant.facebookUrl && self.facebookUrl &&
        [otherMerchant.facebookUrl isEqualToString:self.facebookUrl]));

    BOOL featuredEqual = ((!otherMerchant.featured && !self.featured) ||
        (otherMerchant.featured && self.featured &&
        [otherMerchant.featured intValue] == [self.featured intValue]));

    BOOL imageUrl1Equal = ((!otherMerchant.imageUrl_280x128_1x && !self.imageUrl_280x128_1x) ||
        (otherMerchant.imageUrl_280x128_1x && self.imageUrl_280x128_1x &&
        [otherMerchant.imageUrl_280x128_1x isEqualToString:self.imageUrl_280x128_1x]));

    BOOL imageUrl2Equal = ((!otherMerchant.imageUrl_280x128_2x && !self.imageUrl_280x128_2x) ||
        (otherMerchant.imageUrl_280x128_2x && self.imageUrl_280x128_2x &&
        [otherMerchant.imageUrl_280x128_2x isEqualToString:self.imageUrl_280x128_2x]));

    BOOL locationsEqual = ((!otherMerchant.locations && !self.locations) ||
        (otherMerchant.locations && self.locations &&
        [otherMerchant.locations isEqualToArray:self.locations]));

    BOOL loyaltyEqual = ((!otherMerchant.loyalty && !self.loyalty) ||
        (otherMerchant.loyalty && self.loyalty &&
        [otherMerchant.loyalty isEqual:self.loyalty]));

    BOOL loyaltyEnabledEqual = ((!otherMerchant.loyaltyEnabled && !self.loyaltyEnabled) ||
        (otherMerchant.loyaltyEnabled && self.loyaltyEnabled &&
        [otherMerchant.loyaltyEnabled intValue] == [self.loyaltyEnabled intValue]));

    BOOL messageForTwitterEqual = ((!otherMerchant.messageForTwitter && !self.messageForTwitter) ||
        (otherMerchant.messageForTwitter && self.messageForTwitter &&
        [otherMerchant.messageForTwitter isEqualToString:self.messageForTwitter]));

    BOOL modelIdEqual = ((!otherMerchant.modelId && !self.modelId) ||
        (otherMerchant.modelId && self.modelId &&
        [otherMerchant.modelId intValue] == [self.modelId intValue]));

    BOOL nameEqual = ((!otherMerchant.name && !self.name) ||
        (otherMerchant.name && self.name &&
        [otherMerchant.name isEqualToString:self.name]));

    BOOL newsletterUrlEqual = ((!otherMerchant.newsletterUrl && !self.newsletterUrl) ||
        (otherMerchant.newsletterUrl && self.newsletterUrl &&
        [otherMerchant.newsletterUrl isEqualToString:self.newsletterUrl]));

    BOOL onboardingEqual = ((!otherMerchant.onboarding && !self.onboarding) ||
        (otherMerchant.onboarding && self.onboarding &&
        [otherMerchant.onboarding isEqual:self.onboarding]));

    BOOL opentableUrlEqual = ((!otherMerchant.opentableUrl && !self.opentableUrl) ||
        (otherMerchant.opentableUrl && self.opentableUrl &&
        [otherMerchant.opentableUrl isEqualToString:self.opentableUrl]));

    BOOL publicUrlEqual = ((!otherMerchant.publicUrl && !self.publicUrl) ||
        (otherMerchant.publicUrl && self.publicUrl &&
        [otherMerchant.publicUrl isEqualToString:self.publicUrl]));

    BOOL scvngrUrlEqual = ((!otherMerchant.scvngrUrl && !self.scvngrUrl) ||
        (otherMerchant.scvngrUrl && self.scvngrUrl &&
        [otherMerchant.scvngrUrl isEqualToString:self.scvngrUrl]));

    BOOL searchNormalizedNameEqual = ((!otherMerchant.searchNormalizedName && !self.searchNormalizedName) ||
        (otherMerchant.searchNormalizedName && self.searchNormalizedName &&
        [otherMerchant.searchNormalizedName isEqualToString:self.searchNormalizedName]));

    BOOL spendEqual = ((!otherMerchant.spend && !self.spend) ||
        (otherMerchant.spend && self.spend &&
        [otherMerchant.spend isEqual:self.spend]));

    BOOL twitterUsernameEqual = ((!otherMerchant.twitterUsername && !self.twitterUsername) ||
        (otherMerchant.twitterUsername && self.twitterUsername &&
        [otherMerchant.twitterUsername isEqualToString:self.twitterUsername]));

    BOOL urlEqual = ((!otherMerchant.url && !self.url) ||
        (otherMerchant.url && self.url &&
        [otherMerchant.url isEqualToString:self.url]));

    BOOL yelpUrlEqual = ((!otherMerchant.yelpUrl && !self.yelpUrl) ||
        (otherMerchant.yelpUrl && self.yelpUrl &&
        [otherMerchant.yelpUrl isEqualToString:self.yelpUrl]));

    return categoryImageUrl1Equal && categoryImageUrl2Equal && descriptionEqual && descriptionHtmlEqual &&
        earnEqual && emailCaptureCohortEqual && facebookUrlEqual && featuredEqual &&
        imageUrl1Equal && imageUrl2Equal && locationsEqual && loyaltyEqual &&
        loyaltyEnabledEqual && messageForTwitterEqual && modelIdEqual && nameEqual &&
        newsletterUrlEqual && onboardingEqual && opentableUrlEqual && publicUrlEqual &&
        scvngrUrlEqual && searchNormalizedNameEqual && spendEqual && twitterUsernameEqual &&
        urlEqual && yelpUrlEqual;
  }

  return NO;
}

@end
