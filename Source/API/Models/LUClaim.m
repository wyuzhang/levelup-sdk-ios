#import "LUClaim.h"

@implementation LUClaim

#pragma mark - Creation

- (id)initWithCampaign:(LUCampaign *)campaign claimID:(NSNumber *)claimID cohort:(LUCohort *)cohort
           shareCohort:(LUCohort *)shareCohort {
  self = [super init];
  if (!self) return nil;

  _campaign = campaign;
  _claimID = claimID;
  _cohort = cohort;
  _shareCohort = shareCohort;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:@"LUClaim [campaign=%@, cohort=%@, ID=%@, shareCohort=%@]",
          self.campaign, self.cohort, self.claimID, self.shareCohort];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUClaim [campaign=%@, ID=%@]", self.campaign, self.claimID];
}

@end
