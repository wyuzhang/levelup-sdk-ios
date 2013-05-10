#import "LUCause.h"
#import "LUCause+FakeInstance.h"
#import "LUCauseAffiliation.h"

@implementation LUCauseAffiliation (FakeInstance)

+ (LUCauseAffiliation *)fakeInstance {
  LUCause *cause = [LUCause fakeInstanceWithNoRequirements];
  return [[LUCauseAffiliation alloc] initWithCauseID:cause.causeID percentDonation:@50];
}

@end
