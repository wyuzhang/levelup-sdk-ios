#import "LUCampaign+FakeInstance.h"
#import "LUInterstitialAction+FakeInstance.h"

@implementation LUInterstitialAction (FakeInstance)

+ (LUInterstitialAction *)fakeInstanceForCustomerAquisition {
  return [[LUInterstitialAction alloc] initWithCampaign:[LUCampaign fakeInstance]
                                   interstitialActionID:@1
                                                   type:LUInterstitialActionTypeCustomerAcquisitionShare];
}

+ (LUInterstitialAction *)fakeInstanceForEmailCapture {
  return [[LUInterstitialAction alloc] initWithCampaign:[LUCampaign fakeInstance]
                                   interstitialActionID:@2
                                                   type:LUInterstitialActionTypeEmailCaptureClaim];
}

@end
