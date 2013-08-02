#import "LUInterstitial+Fixtures.h"
#import "LUInterstitialJSONFactory.h"

@implementation LUInterstitial (Fixtures)

+ (LUInterstitial *)fullClaimActionInterstitial {
  return [[LUInterstitialJSONFactory factory] fromJSONObject:[self fullClaimActionJSONObject]];
}

+ (NSDictionary *)fullClaimActionJSONObject {
  return @{
    @"action" : @{
      @"code" : @"testcode",
    },
    @"description_html" : @"<p>interstitial description</p>",
    @"image_url" : @"http://example.com/interstitial-image",
    @"title" : @"Interstitial Title",
    @"type" : @"claim"
  };
}

+ (LUInterstitial *)fullNoActionInterstitial {
  return [[LUInterstitialJSONFactory factory] fromJSONObject:[self fullNoActionJSONObject]];
}

+ (NSDictionary *)fullNoActionJSONObject {
  return @{
    @"description_html" : @"<p>interstitial description</p>",
    @"image_url" : @"http://example.com/interstitial-image",
    @"title" : @"Interstitial Title",
    @"type" : @"no_action"
  };
}

+ (LUInterstitial *)fullShareActionInterstitial {
  return [[LUInterstitialJSONFactory factory] fromJSONObject:[self fullShareActionJSONObject]];
}

+ (NSDictionary *)fullShareActionJSONObject {
  return @{
    @"action" : @{
      @"message_for_email_subject" : @"email subject",
      @"message_for_email_body" : @"email body",
      @"message_for_facebook" : @"facebook message",
      @"message_for_twitter" : @"twitter message",
      @"share_url_email" : @"http://example.com/email",
      @"share_url_facebook" : @"http://example.com/facebook",
      @"share_url_twitter" : @"http://example.com/twitter",
    },
    @"description_html" : @"<p>interstitial description</p>",
    @"image_url" : @"http://example.com/interstitial-image",
    @"title" : @"Interstitial Title",
    @"type" : @"share"
  };
}

+ (LUInterstitial *)fullURLActionInterstitial {
  return [[LUInterstitialJSONFactory factory] fromJSONObject:[self fullURLActionJSONObject]];
}

+ (NSDictionary *)fullURLActionJSONObject {
  return @{
    @"action" : @{
      @"url" : @"http://example.com",
    },
    @"description_html" : @"<p>interstitial description</p>",
    @"image_url" : @"http://example.com/interstitial-image",
    @"title" : @"Interstitial Title",
    @"type" : @"url"
  };
}

@end
