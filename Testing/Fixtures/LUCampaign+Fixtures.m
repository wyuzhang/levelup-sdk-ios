/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
