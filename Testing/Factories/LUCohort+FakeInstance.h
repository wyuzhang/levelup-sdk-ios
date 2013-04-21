@interface LUCohort (FakeInstance)

+ (NSArray *)fakeInstancesForAllAvailableCohorts;
+ (LUCohort *)fakeInstanceForEmail;
+ (LUCohort *)fakeInstanceForFacebook;
+ (LUCohort *)fakeInstanceForReferAFriend;
+ (LUCohort *)fakeInstanceForTwitter;

@end
