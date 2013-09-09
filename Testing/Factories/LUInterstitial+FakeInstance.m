// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUInterstitial+FakeInstance.h"
#import "LUInterstitialClaimAction.h"
#import "LUInterstitialShareAction.h"
#import "LUInterstitialURLAction.h"

@implementation LUInterstitial (FakeInstance)

+ (LUInterstitial *)fakeInstanceWithClaimAction {
  LUInterstitialClaimAction *action = [[LUInterstitialClaimAction alloc] initWithCampaignCode:@"code"];
  return [self fakeInstanceWithAction:action actionType:LUInterstitialActionTypeClaim];
}

+ (LUInterstitial *)fakeInstanceWithNoAction {
  return [self fakeInstanceWithAction:nil actionType:LUInterstitialActionTypeNone];
}

+ (LUInterstitial *)fakeInstanceWithShareAction {
  NSString *messageForEmailBody = @"Email body message";
  NSString *messageForEmailSubject = @"Email subject";
  NSString *messageForFacebook = @"Facebook message";
  NSString *messageForTwitter = @"Twitter message";
  NSURL *shareURLEmail = [NSURL URLWithString:@"http://example.com/email_campaign"];
  NSURL *shareURLFacebook = [NSURL URLWithString:@"http://example.com/facebook_campaign"];
  NSURL *shareURLTwitter = [NSURL URLWithString:@"http://example.com/twitter_campaign"];

  LUInterstitialShareAction *action = [[LUInterstitialShareAction alloc] initWithMessageForEmailBody:messageForEmailBody
                                                                              messageForEmailSubject:messageForEmailSubject
                                                                                  messageForFacebook:messageForFacebook
                                                                                   messageForTwitter:messageForTwitter
                                                                                       shareURLEmail:shareURLEmail
                                                                                    shareURLFacebook:shareURLFacebook
                                                                                     shareURLTwitter:shareURLTwitter];
  return [self fakeInstanceWithAction:action actionType:LUInterstitialActionTypeShare];
}

+ (LUInterstitial *)fakeInstanceWithURLAction {
  LUInterstitialURLAction *action = [[LUInterstitialURLAction alloc] initWithURL:[NSURL URLWithString:@"http://example.com"]];
  return [self fakeInstanceWithAction:action actionType:LUInterstitialActionTypeURL];
}

#pragma mark - Private Methods

+ (LUInterstitial *)fakeInstanceWithAction:(id)action actionType:(LUInterstitialActionType)actionType {
  return [[LUInterstitial alloc] initWithAction:action
                                     actionType:actionType
                                descriptionHTML:@"<p>Grab $1.00 to spend on anything at Test Merchant. Enjoy!</p>"
                                       imageURL:[NSURL URLWithString:@"https://www.staging-levelup.com/v14/campaigns/1/image"]
                                          title:@"$1 at Test Merchant"];
}

@end
