// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUCampaign.h"
#import "LUMonetaryValue.h"
#import "NSString+HTMLStripping.h"
#import "NSURL+LUAdditions.h"

@implementation LUCampaign

#pragma mark - Creation

- (id)initWithCampaignID:(NSNumber *)campaignID confirmationHTML:(NSString *)confirmationHTML global:(BOOL)global
     messageForEmailBody:(NSString *)messageForEmailBody messageForEmailSubject:(NSString *)messageForEmailSubject
      messageForFacebook:(NSString *)messageForFacebook messageForTwitter:(NSString *)messageForTwitter
                    name:(NSString *)name offerHTML:(NSString *)offerHTML shareable:(BOOL)shareable
           shareURLEmail:(NSURL *)shareURLEmail shareURLFacebook:(NSURL *)shareURLFacebook
         shareURLTwitter:(NSURL *)shareURLTwitter sponsor:(NSString *)sponsor value:(LUMonetaryValue *)value {
  self = [super init];
  if (!self) return nil;

  _campaignID = campaignID;
  _confirmationHTML = confirmationHTML;
  _global = global;
  _messageForEmailBody = messageForEmailBody;
  _messageForEmailSubject = messageForEmailSubject;
  _messageForFacebook = messageForFacebook;
  _messageForTwitter = messageForTwitter;
  _name = name;
  _offerHTML = offerHTML;
  _shareable = shareable;
  _shareURLEmail = shareURLEmail;
  _shareURLFacebook = shareURLFacebook;
  _shareURLTwitter = shareURLTwitter;
  _sponsor = sponsor;
  _value = value;

  return self;
}


#pragma mark - Public Methods

- (NSString *)confirmationText {
  return [self.confirmationHTML lu_stringByStrippingHTML];
}

- (NSURL *)imageURL {
  return [NSURL lu_imageURLForCampaignWithID:self.campaignID];
}

- (NSString *)offerText {
  return [self.offerHTML lu_stringByStrippingHTML];
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"LUCampaign [confirmationHTML=%@, global=%@, messageForEmailBody=%@, messageForEmailSubject=%@, messageForFacebook=%@, messageForTwitter=%@, ID=%@, name=%@, offerHTML=%@, shareable=%@, shareURLEmail=%@, shareURLFacebook=%@, shareURLTwitter=%@, sponsor=%@, value=%@]",
          self.confirmationHTML, @(self.global), self.messageForEmailBody, self.messageForEmailSubject,
          self.messageForFacebook, self.messageForTwitter, self.campaignID, self.name, self.offerHTML,
          @(self.shareable), self.shareURLEmail, self.shareURLFacebook, self.shareURLTwitter, self.sponsor, self.value];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUCampaign [ID=%@, name=%@, value=%@]", self.campaignID, self.name, self.value];
}

@end
