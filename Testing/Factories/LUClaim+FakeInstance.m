#import "LUCampaign+FakeInstance.h"
#import "LUClaim+FakeInstance.h"
#import "LUCohort+FakeInstance.h"
#import "NSArray+LUAdditions.h"

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

+ (LUClaim *)fakeInstanceForMerchantWithID:(NSNumber *)merchantID {
    LUClaim *claim = [self fakeInstance];
    [[claim.campaign.merchants lu_firstObject] setValue:merchantID forKey:@"merchantID"];
    return claim;
}

@end
