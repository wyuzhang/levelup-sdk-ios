#import "LUInterstitialActionJSONFactory.h"

SPEC_BEGIN(LUInterstitialActionJSONFactorySpec)

describe(@"LUInterstitialActionJSONFactory", ^{
  __block LUInterstitialActionJSONFactory *factory;

  beforeEach(^{
    factory = [LUInterstitialActionJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUInterstitialAction", ^{
      LUInterstitialAction *interstitialAction = [factory createFromAttributes:[LUInterstitialAction fullJSONObject]];

      [[interstitialAction.campaign should] equal:[LUCampaign fullCampaign]];
      [[interstitialAction.interstitialActionID should] equal:@1];
      [[theValue(interstitialAction.type) should] equal:theValue(LUInterstitialActionTypeCustomerAcquisitionShare)];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'interstitial_action'", ^{
      [[[factory rootKey] should] equal:@"interstitial_action"];
    });
  });
});

SPEC_END
