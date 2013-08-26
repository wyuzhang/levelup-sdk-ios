#import "LUCampaign+FakeInstance.h"
#import "LUMonetaryValue.h"

@implementation LUCampaign (FakeInstance)

+ (LUCampaign *)fakeGlobalInstance {
  LUCampaign *campaign = [self fakeInstance];
  [campaign setValue:@YES forKey:@"global"];
  return campaign;
}

+ (LUCampaign *)fakeInstance {
  return [[LUCampaign alloc] initWithCampaignID:@1
                               confirmationHTML:@"<p>You just loaded $5 to your account. Visit the nearest store and pay with the app to use it.</p>"
                                         global:NO
                            messageForEmailBody:@"Email body message"
                         messageForEmailSubject:@"Email subject"
                             messageForFacebook:@"Facebook message"
                              messageForTwitter:@"Twitter message"
                                           name:@"Test Campaign"
                                      offerHTML:@"<p>offer</p>"
                                      shareable:YES
                                  shareURLEmail:[NSURL URLWithString:@"http://example.com/email_campaign"]
                               shareURLFacebook:[NSURL URLWithString:@"http://example.com/facebook_campaign"]
                                shareURLTwitter:[NSURL URLWithString:@"http://example.com/twitter_campaign"]
                                        sponsor:@"Test Merchant"
                                          value:[LUMonetaryValue monetaryValueWithUSD:@5]];
}

+ (LUCampaign *)fakeInstanceWithCampaignID:(NSNumber *)campaignID {
  LUCampaign *campaign = [self fakeInstance];
  [campaign setValue:campaignID forKey:@"campaignID"];
  return campaign;
}

+ (LUCampaign *)fakeInstanceWithConfirmationHTML:(NSString *)confirmationHTML offerHTML:(NSString *)offerHTML {
  LUCampaign *campaign = [self fakeInstance];
  [campaign setValue:confirmationHTML forKey:@"confirmationHTML"];
  [campaign setValue:offerHTML forKey:@"offerHTML"];
  return campaign;
}

@end
