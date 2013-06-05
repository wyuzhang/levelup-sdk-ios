#import "LUCampaign+FakeInstance.h"
#import "LUCohort+FakeInstance.h"
#import "LUMerchant+FakeInstance.h"
#import "LUMonetaryValue.h"

@implementation LUCampaign (FakeInstance)

+ (LUCampaign *)fakeGlobalInstance {
  LUCampaign *campaign = [self fakeInstance];
  [campaign setValue:@YES forKey:@"global"];
  [campaign setValue:@[] forKey:@"merchants"];
  return campaign;
}
+ (LUCampaign *)fakeInstance {
  NSURL *imageURL_1x = [NSURL URLWithString:@"https://s3.amazonaws.com/levelup-production/campaigns/3944/mobile_images/original/iStock_000004840813XSmall.jpg?1360594142"];
  NSURL *imageURL_2x = [NSURL URLWithString:@"https://s3.amazonaws.com/levelup-production/campaigns/3944/mobile_images/original/iStock_000004840813XSmall.jpg?1360594142"];

  return [[LUCampaign alloc] initWithCampaignID:@1
                                        claimed:NO
                                        cohorts:[LUCohort fakeInstancesForAllAvailableCohorts]
                               confirmationHTML:@"<p>You just loaded $1 to your account. Visit the nearest store and pay with the app to use it.</p>"
                                         global:NO
                                    imageURL_1x:imageURL_1x imageURL_2x:imageURL_2x
                                      merchants:@[[LUMerchant fakeInstance]]
                                           name:@"Test Campaign"
                                      offerHTML:@"<p>offer</p>"
                             referAFriendCohort:nil
                                        sponsor:@"Test Merchant"
                                   supportEmail:@"test@example.com"
                                          value:[LUMonetaryValue monetaryValueWithUSD:@1]];
}

+ (LUCampaign *)fakeInstanceWithConfirmationHTML:(NSString *)confirmationHTML offerHTML:(NSString *)offerHTML {
  LUCampaign *campaign = [self fakeInstance];
  [campaign setValue:confirmationHTML forKey:@"confirmationHTML"];
  [campaign setValue:offerHTML forKey:@"offerHTML"];
  return campaign;
}

+ (LUCampaign *)fakeInstanceWithImageURL_1x:(NSURL *)imageURL_1x imageURL_2x:(NSURL *)imageURL_2x {
  LUCampaign *campaign = [self fakeInstance];
  [campaign setValue:imageURL_1x forKey:@"imageURL_1x"];
  [campaign setValue:imageURL_2x forKey:@"imageURL_2x"];
  return campaign;
}

+ (LUCampaign *)fakeInstanceWithReferAFriendCohort {
  LUCampaign *campaign = [self fakeInstance];
  [campaign setValue:[LUCohort fakeInstanceForReferAFriend] forKey:@"referAFriendCohort"];
  return campaign;
}

@end
