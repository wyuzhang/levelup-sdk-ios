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
      NSDictionary *JSON = @{
        @"callout_text" : @"test callout",
        @"description_html" : @"<p>interstitial description</p>",
        @"image_url" : @"http://example.com/interstitial-image",
        @"title" : @"Interstitial Title",
        @"type" : @"no_action"
      };
      LUInterstitial *interstitial = [factory createFromAttributes:JSON];

      [interstitial.action shouldBeNil];
      [[theValue(interstitial.actionType) should] equal:theValue(LUInterstitialActionTypeNone)];

      [[interstitial.calloutText should] equal:@"test callout"];
      [[interstitial.descriptionHTML should] equal:@"<p>interstitial description</p>"];
      [[[interstitial.imageURL absoluteString] should] match:hasPrefix(@"http://example.com/interstitial-image")];
      [[interstitial.title should] equal:@"Interstitial Title"];
    });

    it(@"parses a JSON dictionary with a claim action into an LUInterstitial", ^{
      NSDictionary *JSON = @{
        @"action" : @{
          @"code" : @"testcode",
        },
        @"callout_text" : @"test callout",
        @"description_html" : @"<p>interstitial description</p>",
        @"image_url" : @"http://example.com/interstitial-image",
        @"title" : @"Interstitial Title",
        @"type" : @"claim"
      };
      LUInterstitial *interstitial = [factory createFromAttributes:JSON];

      [[interstitial.action should] beKindOfClass:[LUInterstitialClaimAction class]];
      [[[interstitial.action campaignCode] should] equal:@"testcode"];
      [[theValue(interstitial.actionType) should] equal:theValue(LUInterstitialActionTypeClaim)];

      [[interstitial.calloutText should] equal:@"test callout"];
      [[interstitial.descriptionHTML should] equal:@"<p>interstitial description</p>"];
      [[[interstitial.imageURL absoluteString] should] match:hasPrefix(@"http://example.com/interstitial-image")];
      [[interstitial.title should] equal:@"Interstitial Title"];
    });

    context(@"feedback interstitials", ^{
      NSDictionary *JSON = @{
        @"action" : @{
          @"question_text" : @"test question",
        },
        @"callout_text" : @"test callout",
        @"description_html" : @"<p>interstitial description</p>",
        @"image_url" : @"http://example.com/interstitial-image",
        @"title" : @"Interstitial Title",
        @"type" : @"feedback"
      };

      it(@"parses a JSON dictionary with a feedback action into an LUInterstitial", ^{
        LUInterstitial *interstitial = [factory createFromAttributes:JSON];

        [[interstitial.action should] beKindOfClass:[LUInterstitialFeedbackAction class]];
        [[[interstitial.action questionText] should] equal:@"test question"];
        [[theValue(interstitial.actionType) should] equal:theValue(LUInterstitialActionTypeFeedback)];

        [[interstitial.calloutText should] equal:@"test callout"];
        [[interstitial.descriptionHTML should] equal:@"<p>interstitial description</p>"];
        [[[interstitial.imageURL absoluteString] should] match:hasPrefix(@"http://example.com/interstitial-image")];
        [[interstitial.title should] equal:@"Interstitial Title"];
      });

      it(@"accepts 'collect_feedback' as an interstitial type", ^{
        NSMutableDictionary *alternateJSON = [JSON mutableCopy];
        alternateJSON[@"type"] = @"collect_feedback";

        LUInterstitial *interstitial = [factory createFromAttributes:alternateJSON];
        [[theValue(interstitial.actionType) should] equal:theValue(LUInterstitialActionTypeFeedback)];
      });
    });

    it(@"parses a JSON dictionary with a share action into an LUInterstitial", ^{
      NSDictionary *JSON = @{
        @"action" : @{
          @"message_for_email_subject" : @"email subject",
          @"message_for_email_body" : @"email body",
          @"message_for_facebook" : @"facebook message",
          @"message_for_twitter" : @"twitter message",
          @"share_url_email" : @"http://example.com/email",
          @"share_url_facebook" : @"http://example.com/facebook",
          @"share_url_twitter" : @"http://example.com/twitter",
        },
        @"callout_text" : @"test callout",
        @"description_html" : @"<p>interstitial description</p>",
        @"image_url" : @"http://example.com/interstitial-image",
        @"title" : @"Interstitial Title",
        @"type" : @"share"
      };
      LUInterstitial *interstitial = [factory createFromAttributes:JSON];

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
      NSDictionary *JSON = @{
        @"action" : @{
          @"url" : @"http://example.com",
        },
        @"callout_text" : @"test callout",
        @"description_html" : @"<p>interstitial description</p>",
        @"image_url" : @"http://example.com/interstitial-image",
        @"title" : @"Interstitial Title",
        @"type" : @"url"
      };
      LUInterstitial *interstitial = [factory createFromAttributes:JSON];

      [[interstitial.action should] beKindOfClass:[LUInterstitialURLAction class]];
      [[[interstitial.action URL] should] equal:[NSURL URLWithString:@"http://example.com"]];
      [[theValue(interstitial.actionType) should] equal:theValue(LUInterstitialActionTypeURL)];

      [[interstitial.calloutText should] equal:@"test callout"];
      [[interstitial.descriptionHTML should] equal:@"<p>interstitial description</p>"];
      [[[interstitial.imageURL absoluteString] should] match:hasPrefix(@"http://example.com/interstitial-image")];
      [[interstitial.title should] equal:@"Interstitial Title"];
    });

    it(@"parses a JSON dictionary with an unknown type into an LUInterstitial", ^{
      NSDictionary *JSON = @{
        @"action" : @{
          @"random" : @"example",
        },
        @"callout_text" : @"test callout",
        @"description_html" : @"<p>interstitial description</p>",
        @"image_url" : @"http://example.com/interstitial-image",
        @"title" : @"Interstitial Title",
        @"type" : @"unknown type"
      };
      LUInterstitial *interstitial = [factory createFromAttributes:JSON];

      [[interstitial.action should] beNil];
      [[theValue(interstitial.actionType) should] equal:theValue(LUInterstitialActionTypeUnknown)];

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
