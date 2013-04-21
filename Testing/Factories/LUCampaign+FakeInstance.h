@interface LUCampaign (FakeInstance)

+ (LUCampaign *)fakeInstance;
+ (LUCampaign *)fakeInstanceWithConfirmationHTML:(NSString *)confirmationHTML offerHTML:(NSString *)offerHTML;
+ (LUCampaign *)fakeInstanceWithImageURL_1x:(NSURL *)imageURL_1x imageURL_2x:(NSURL *)imageURL_2x;
+ (LUCampaign *)fakeInstanceWithReferAFriendCohort;

@end
