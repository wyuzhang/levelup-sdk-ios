#import "LUCampaign+FakeInstance.h"
#import "LUClaim+FakeInstance.h"
#import "LUCohort+FakeInstance.h"

@implementation LUClaim (FakeInstance)

+ (LUClaim *)fakeGlobalInstance {
  return [[LUClaim alloc] initWithCampaign:[LUCampaign fakeGlobalInstance]
                                   claimID:@1
                                    cohort:[LUCohort fakeInstanceForEmail]
                               shareCohort:[LUCohort fakeInstanceForFacebook]];
}

+ (LUClaim *)fakeInstance {
  return [[LUClaim alloc] initWithCampaign:[LUCampaign fakeInstance]
                                   claimID:@1
                                    cohort:[LUCohort fakeInstanceForEmail]
                               shareCohort:[LUCohort fakeInstanceForFacebook]];
}

@end
