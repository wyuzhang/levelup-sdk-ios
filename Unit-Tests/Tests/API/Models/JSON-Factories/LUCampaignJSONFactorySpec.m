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

#import "LUCampaignJSONFactory.h"

SPEC_BEGIN(LUCampaignJSONFactorySpec)

describe(@"LUCampaignJSONFactory", ^{
  __block LUCampaignJSONFactory *factory;

  beforeEach(^{
    factory = [LUCampaignJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUCampaign", ^{
      NSDictionary *JSON = @{
        @"applies_to_all_merchants" : @NO,
        @"confirmation_html" : @"<p>confirmation</p>",
        @"id" : @1,
        @"message_for_email_body" : @"email body",
        @"message_for_email_subject" : @"email subject",
        @"message_for_facebook" : @"facebook message",
        @"message_for_twitter" : @"twitter message",
        @"name" : @"Test Campaign",
        @"offer_html" : @"<p>offer</p>",
        @"share_url_email" : @"http://example.com/EM-TEST",
        @"share_url_facebook" : @"http://example.com/FB-TEST",
        @"share_url_twitter" : @"http://example.com/TW-TEST",
        @"sponsor" : @"Sponsor",
        @"value_amount" : @100
      };
      LUCampaign *campaign = [factory createFromAttributes:JSON];

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
      [[campaign.value should] equal:[LUMonetaryValue monetaryValueWithUSCents:@100]];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'campaign'", ^{
      [[[factory rootKey] should] equal:@"campaign"];
    });
  });
});

SPEC_END
