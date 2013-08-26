#import "LUCampaign.h"

@interface LUCampaign (FakeInstance)

+ (LUCampaign *)fakeGlobalInstance;
+ (LUCampaign *)fakeInstance;
+ (LUCampaign *)fakeInstanceWithCampaignID:(NSNumber *)campaignID;
+ (LUCampaign *)fakeInstanceWithConfirmationHTML:(NSString *)confirmationHTML offerHTML:(NSString *)offerHTML;

@end
