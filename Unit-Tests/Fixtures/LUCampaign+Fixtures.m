// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUCampaign+Fixtures.h"
#import "LUCampaignJSONFactory.h"

@implementation LUCampaign (Fixtures)

+ (LUCampaign *)fullCampaign {
  return [[LUCampaignJSONFactory factory] fromJSONObject:[self fullJSONObject]];
}

+ (NSDictionary *)fullJSONObject {
  return @{
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
    @"value_amount" : [LUMonetaryValue fullMonetaryValue].amount
  };
}

+ (LUCampaign *)minimalCampaign {
  return [[LUCampaignJSONFactory factory] fromJSONObject:[self minimalJSONObject]];
}

+ (NSDictionary *)minimalJSONObject {
  return @{
    @"id" : @1
  };
}

@end
