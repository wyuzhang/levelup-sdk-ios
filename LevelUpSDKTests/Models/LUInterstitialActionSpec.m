#import "LUCampaign.h"
#import "LUInterstitialAction.h"

SPEC_BEGIN(LUInterstitialActionSpec)

describe(@"LUInterstitialAction", ^{
  LUInterstitialAction *interstitialActionA = [[LUInterstitialAction alloc] init];
  LUInterstitialAction *interstitialActionB = [[LUInterstitialAction alloc] init];
  LUCampaign *campaignA = [[LUCampaign alloc] init];
  [campaignA setName:@"campA"];
  LUCampaign *campaignB = [[LUCampaign alloc] init];
  [campaignB setName:@"campB"];

  describe(@"isEqual:", ^{
    it(@"returns YES for an equivalent object", ^{
      interstitialActionA.campaign = campaignA;
      interstitialActionB.campaign = campaignA;

      [[theValue([interstitialActionA isEqual:interstitialActionB]) should] equal:theValue(YES)];
    });

    it(@"returns YES for an equivalent object - reflexively", ^{
      interstitialActionA.campaign = campaignA;
      interstitialActionB.campaign = campaignA;

      [[theValue([interstitialActionB isEqual:interstitialActionA]) should] equal:theValue(YES)];
    });

    it(@"returns NO when a previously equivalent object changes", ^{
      interstitialActionA.campaign = campaignA;
      interstitialActionB.campaign = campaignA;

      [[theValue([interstitialActionA isEqual:interstitialActionB]) should] equal:theValue(YES)];

      interstitialActionB.campaign = campaignB;

      [[theValue([interstitialActionA isEqual:interstitialActionB]) should] equal:theValue(NO)];
    });

    it(@"returns YES when a previously inequivalent object changes to match this one", ^{
      interstitialActionB.campaign = campaignA;
      interstitialActionB.campaign = campaignB;

      [[theValue([interstitialActionA isEqual:interstitialActionB]) should] equal:theValue(NO)];

      interstitialActionB.campaign = campaignA;

      [[theValue([interstitialActionA isEqual:interstitialActionB]) should] equal:theValue(YES)];
    });
  });

  describe(@"hash", ^{
    it(@"generates same hash for an equivalent object", ^{
      interstitialActionA.campaign = campaignA;
      interstitialActionB.campaign = campaignA;

      [[theValue([interstitialActionA hash]) should] equal:theValue([interstitialActionB hash])];
    });

    it(@"generates different hash after a previously equivalent object changes", ^{
      interstitialActionA.campaign = campaignA;
      interstitialActionB.campaign = campaignA;

      [[theValue([interstitialActionA hash]) should] equal:theValue([interstitialActionB hash])];

      interstitialActionB.campaign = campaignB;

      [[theValue([interstitialActionA hash]) shouldNot] equal:theValue([interstitialActionB hash])];
    });

    it(@"generates equal hashes after a previously inequivalent object changes to match this one", ^{
      interstitialActionA.campaign = campaignA;
      interstitialActionB.campaign = campaignB;

      [[theValue([interstitialActionA hash]) shouldNot] equal:theValue([interstitialActionB hash])];

      interstitialActionB.campaign = campaignA;

      [[theValue([interstitialActionA hash]) should] equal:theValue([interstitialActionB hash])];
    });
  });
});

SPEC_END
