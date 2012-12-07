#import "LUCampaign.h"
#import "LUClaim.h"
#import "LUCohort.h"
#import "LUJSONDeserializer.h"

@implementation LUClaim

#pragma mark - Serialization

+ (void)load {
  @autoreleasepool {
    [LUJSONDeserializer registerModel:[self class] withIdentifier:@"claim"];
  }
}

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  NSUInteger total = 0;

  if (self.campaign) {
    total += [self.campaign hash] * 11;
  }
  if (self.cohort) {
    total += [self.cohort hash] * 13;
  }
  if (self.modelId) {
    total += [self.modelId intValue] * 17;
  }
  if (self.shareCohort) {
    total += [self.shareCohort hash] * 19;
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(otherObject && [otherObject isKindOfClass:[LUClaim class]]) {
    LUClaim *otherClaim = (LUClaim *)otherObject;

    BOOL campaignEqual = ((!otherClaim.campaign && !self.campaign) ||
        (otherClaim.campaign && self.campaign&&
        [otherClaim.campaign isEqual:self.campaign]));

    BOOL cohortEqual = ((!otherClaim.cohort && !self.cohort) ||
        (otherClaim.cohort && self.cohort &&
        [otherClaim.cohort isEqual:self.cohort]));

    BOOL modelIdEqual = ((!otherClaim.modelId && !self.modelId) ||
        (otherClaim.modelId && self.modelId &&
        [otherClaim.modelId intValue] == [self.modelId intValue]));

    BOOL shareCohortEqual = ((!otherClaim.shareCohort && !self.shareCohort) ||
        (otherClaim.shareCohort && self.shareCohort &&
        [otherClaim.shareCohort isEqual:self.shareCohort]));

    return campaignEqual && cohortEqual && modelIdEqual && shareCohortEqual;
  }

  return NO;
}

@end
