#import "LUClaim.h"

@implementation LUClaim

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:@"Claim [campaign=%@, cohort=%@, ID=%@, shareCohort=%@]",
          self.campaign, self.cohort, self.claimID, self.shareCohort];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"Claim [campaign=%@, ID=%@]", self.campaign, self.claimID];
}

@end
