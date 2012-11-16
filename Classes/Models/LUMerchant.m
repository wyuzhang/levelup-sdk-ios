#import "LUCohort.h"
#import "LUJSONDeserializer.h"
#import "LULocation.h"
#import "LULoyalty.h"
#import "LUMerchant.h"
#import "LUMonetaryValue.h"
#import "LUUser.h"
#import "NSString+Escaping.h"

@implementation LUMerchant

#pragma mark -
#pragma mark Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"merchant"];
  }
}

#pragma mark -
#pragma mark Public Methods

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
  return [self.loyaltyEnabled boolValue] && (nil != self.loyalty);
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

@end
