#import "LUClaim.h"

@interface LUClaim (FakeInstance)

+ (LUClaim *)fakeInstance;
+ (LUClaim *)fakeInstanceForCampaignWithCode:(NSString *)code;

@end
