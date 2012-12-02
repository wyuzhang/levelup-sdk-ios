#import "LUCampaign.h"
#import "LUCohort.h"
#import "LUJSONDeserializer.h"
#import "LUMonetaryValue.h"
#import <UIKit/UIKit.h>

@implementation LUCampaign

#pragma mark -
#pragma mark Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"campaign"];
  }
}

#define kCohortTypeDefaultEmail @"default_email"
#define kCohortTypeDefaultFacebook @"default_facebook"
#define kCohortTypeDefaultTwitter @"default_twitter"

#pragma mark -
#pragma mark Public Methods

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

#pragma mark -
#pragma mark Private Methods

- (LUCohort *)firstCohortOfType:(NSString *)type {
  for (LUCohort *cohort in self.cohorts) {
    if ([cohort.cohortType isEqualToString:type]) {
      return cohort;
    }
  }

  return nil;
}

@end
