#import "LUMerchantJSONFactory.h"

SPEC_BEGIN(LUMerchantJSONFactorySpec)

describe(@"LUMerchantJSONFactory", ^{
  __block LUMerchantJSONFactory *factory;

  beforeEach(^{
    factory = [LUMerchantJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LUMerchant", ^{
      LUMerchant *merchant = [factory createFromAttributes:[LUMerchant fullJSONObject]];

      [[merchant.descriptionHTML should] equal:@"<p>description</p>"];
      [[merchant.earn should] equal:[LUMonetaryValue fullMonetaryValue]];
      [[merchant.facebookURL should] equal:[NSURL URLWithString:@"http://facebook.com/example"]];
      [[theValue(merchant.featured) should] beYes];
      [[[merchant valueForKey:@"imageURL_1x"] should] equal:[NSURL URLWithString:@"http://example.com/image_url_1x"]];
      [[[merchant valueForKey:@"imageURL_2x"] should] equal:[NSURL URLWithString:@"http://example.com/image_url_2x"]];
      [[merchant.locations should] equal:@[[LULocation fullLocation]]];
      [[merchant.loyalty should] equal:[LULoyalty fullLoyalty]];
      [[merchant.merchantID should] equal:@1];
      [[merchant.name should] equal:@"Test Merchant"];
      [[merchant.newsletterURL should] equal:[NSURL URLWithString:@"http://example.com/newsletter"]];
      [[merchant.opentableURL should] equal:[NSURL URLWithString:@"http://example.com/opentable"]];
      [[merchant.publicURL should] equal:[NSURL URLWithString:@"http://example.com"]];
      [[merchant.scvngrURL should] equal:[NSURL URLWithString:@"http://scvngr.com/example"]];
      [[merchant.spend should] equal:[LUMonetaryValue fullMonetaryValue]];
      [[merchant.twitterUsername should] equal:@"example"];
      [[merchant.websiteURL should] equal:[NSURL URLWithString:@"http://example.com/website"]];
      [[merchant.yelpURL should] equal:[NSURL URLWithString:@"http://yelp.com/example"]];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'merchant'", ^{
      [[[factory rootKey] should] equal:@"merchant"];
    });
  });
});

SPEC_END
