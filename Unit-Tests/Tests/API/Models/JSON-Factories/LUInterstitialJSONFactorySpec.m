// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

#import "LUInterstitialJSONFactory.h"

SPEC_BEGIN(LUInterstitialJSONFactorySpec)

describe(@"LUInterstitialJSONFactory", ^{
  __block LUInterstitialJSONFactory *factory;

  beforeEach(^{
    factory = [LUInterstitialJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary with no action into an LUInterstitial", ^{
      LUInterstitial *interstitial = [factory createFromAttributes:[LUInterstitial fullNoActionJSONObject]];

      [interstitial.action shouldBeNil];
      [[theValue(interstitial.actionType) should] equal:theValue(LUInterstitialActionTypeNone)];

      [[interstitial.calloutText should] equal:@"test callout"];
      [[interstitial.descriptionHTML should] equal:@"<p>interstitial description</p>"];
      [[[interstitial.imageURL absoluteString] should] match:hasPrefix(@"http://example.com/interstitial-image")];
      [[interstitial.title should] equal:@"Interstitial Title"];
    });

    it(@"parses a JSON dictionary with a claim action into an LUInterstitial", ^{
      LUInterstitial *interstitial = [factory createFromAttributes:[LUInterstitial fullClaimActionJSONObject]];

      [[interstitial.action should] beKindOfClass:[LUInterstitialClaimAction class]];
      [[[interstitial.action campaignCode] should] equal:@"testcode"];
      [[theValue(interstitial.actionType) should] equal:theValue(LUInterstitialActionTypeClaim)];

      [[interstitial.calloutText should] equal:@"test callout"];
      [[interstitial.descriptionHTML should] equal:@"<p>interstitial description</p>"];
      [[[interstitial.imageURL absoluteString] should] match:hasPrefix(@"http://example.com/interstitial-image")];
      [[interstitial.title should] equal:@"Interstitial Title"];
    });

    it(@"parses a JSON dictionary with a share action into an LUInterstitial", ^{
      LUInterstitial *interstitial = [factory createFromAttributes:[LUInterstitial fullShareActionJSONObject]];

      [[interstitial.action should] beKindOfClass:[LUInterstitialShareAction class]];
      [[[interstitial.action messageForEmailBody] should] equal:@"email body"];
      [[[interstitial.action messageForEmailSubject] should] equal:@"email subject"];
      [[[interstitial.action messageForFacebook] should] equal:@"facebook message"];
      [[[interstitial.action messageForTwitter] should] equal:@"twitter message"];
      [[[interstitial.action shareURLEmail] should] equal:[NSURL URLWithString:@"http://example.com/email"]];
      [[[interstitial.action shareURLFacebook] should] equal:[NSURL URLWithString:@"http://example.com/facebook"]];
      [[[interstitial.action shareURLTwitter] should] equal:[NSURL URLWithString:@"http://example.com/twitter"]];
      [[theValue(interstitial.actionType) should] equal:theValue(LUInterstitialActionTypeShare)];

      [[interstitial.calloutText should] equal:@"test callout"];
      [[interstitial.descriptionHTML should] equal:@"<p>interstitial description</p>"];
      [[[interstitial.imageURL absoluteString] should] match:hasPrefix(@"http://example.com/interstitial-image")];
      [[interstitial.title should] equal:@"Interstitial Title"];
    });

    it(@"parses a JSON dictionary with a URL action into an LUInterstitial", ^{
      LUInterstitial *interstitial = [factory createFromAttributes:[LUInterstitial fullURLActionJSONObject]];

      [[interstitial.action should] beKindOfClass:[LUInterstitialURLAction class]];
      [[[interstitial.action URL] should] equal:[NSURL URLWithString:@"http://example.com"]];
      [[theValue(interstitial.actionType) should] equal:theValue(LUInterstitialActionTypeURL)];

      [[interstitial.calloutText should] equal:@"test callout"];
      [[interstitial.descriptionHTML should] equal:@"<p>interstitial description</p>"];
      [[[interstitial.imageURL absoluteString] should] match:hasPrefix(@"http://example.com/interstitial-image")];
      [[interstitial.title should] equal:@"Interstitial Title"];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'interstitial'", ^{
      [[[factory rootKey] should] equal:@"interstitial"];
    });
  });
});

SPEC_END
