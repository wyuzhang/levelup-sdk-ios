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
      [[theValue(campaign.claimed) should] beYes];
      [[campaign.cohorts should] equal:@[[LUCohort minimalCohort]]];
      [[campaign.confirmationHTML should] equal:@"<p>confirmation</p>"];
      [[theValue(campaign.global) should] beNo];
      [[campaign.merchants should] equal:@[[LUMerchant minimalMerchant]]];
      [[[campaign valueForKey:@"imageURL_1x"] should] equal:[NSURL URLWithString:@"http://example.com/image_url_1x"]];
      [[[campaign valueForKey:@"imageURL_2x"] should] equal:[NSURL URLWithString:@"http://example.com/image_url_2x"]];
      [[campaign.name should] equal:@"Test Campaign"];
      [[campaign.offerHTML should] equal:@"<p>offer</p>"];
      [[[campaign valueForKey:@"referAFriendCohort"] should] equal:[LUCohort fullCohort]];
      [[campaign.sponsor should] equal:@"Sponsor"];
      [[campaign.supportEmail should] equal:@"support@example.com"];
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
