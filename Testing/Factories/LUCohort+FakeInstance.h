#import "LUCohort.h"

@interface LUCohort (FakeInstance)

+ (LUCohort *)fakeInstance;
+ (LUCohort *)fakeInstanceForEmail;
+ (LUCohort *)fakeInstanceForFacebook;
+ (LUCohort *)fakeInstanceForReferAFriend;
+ (LUCohort *)fakeInstanceForTwitter;
+ (NSArray *)fakeInstancesForAllAvailableCohorts;

@end
