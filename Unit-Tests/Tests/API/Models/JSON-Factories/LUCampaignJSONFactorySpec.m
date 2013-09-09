// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUCampaignJSONFactory.h"

SPEC_BEGIN(LUCampaignJSONFactorySpec)

describe(@"LUCampaignJSONFactory", ^{
  __block LUCampaignJSONFactory *factory;

  beforeEach(^{
    factory = [LUCampaignJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUCampaign", ^{
      LUCampaign *campaign = [factory createFromAttributes:[LUCampaign fullJSONObject]];

      [[campaign.campaignID should] equal:@1];
      [[campaign.confirmationHTML should] equal:@"<p>confirmation</p>"];
      [[theValue(campaign.global) should] beNo];
      [[campaign.messageForEmailBody should] equal:@"email body"];
      [[campaign.messageForEmailSubject should] equal:@"email subject"];
      [[campaign.messageForFacebook should] equal:@"facebook message"];
      [[campaign.messageForTwitter should] equal:@"twitter message"];
      [[campaign.name should] equal:@"Test Campaign"];
      [[campaign.offerHTML should] equal:@"<p>offer</p>"];
      [[campaign.shareURLEmail should] equal:[NSURL URLWithString:@"http://example.com/EM-TEST"]];
      [[campaign.shareURLFacebook should] equal:[NSURL URLWithString:@"http://example.com/FB-TEST"]];
      [[campaign.shareURLTwitter should] equal:[NSURL URLWithString:@"http://example.com/TW-TEST"]];
      [[campaign.sponsor should] equal:@"Sponsor"];
      [[campaign.value should] equal:[LUMonetaryValue fullMonetaryValue]];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'campaign'", ^{
      [[[factory rootKey] should] equal:@"campaign"];
    });
  });
});

SPEC_END
