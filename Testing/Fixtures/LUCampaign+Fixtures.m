// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUCampaign+Fixtures.h"
#import "LUMonetaryValue.h"

@implementation LUCampaign (Fixtures)

+ (LUCampaign *)fixture {
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

+ (LUCampaign *)fixtureForGlobalCampaign {
  LUCampaign *campaign = [self fixture];
  [campaign setValue:@YES forKey:@"global"];
  return campaign;
}

+ (LUCampaign *)fixtureWithCampaignID:(NSNumber *)campaignID {
  LUCampaign *campaign = [self fixture];
  [campaign setValue:campaignID forKey:@"campaignID"];
  return campaign;
}

+ (LUCampaign *)fixtureWithConfirmationHTML:(NSString *)confirmationHTML offerHTML:(NSString *)offerHTML {
  LUCampaign *campaign = [self fixture];
  [campaign setValue:confirmationHTML forKey:@"confirmationHTML"];
  [campaign setValue:offerHTML forKey:@"offerHTML"];
  return campaign;
}

@end
