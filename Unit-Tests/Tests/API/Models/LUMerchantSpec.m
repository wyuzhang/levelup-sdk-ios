#import "LULocation.h"
#import "LULoyalty.h"
#import "LUMerchant.h"
#import "LUMonetaryValue.h"

SPEC_BEGIN(LUMerchantSpec)

describe(@"LUMerchant", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUMerchant class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Public Methods

  describe(@"currentCredit", ^{
    context(@"when there is no loyalty", ^{
      LUMerchant *merchant = [LUMerchant fakeInstanceWithoutLoyaltyEnabled];

      it(@"is $0", ^{
        [[[merchant currentCredit] should] equal:[LUMonetaryValue monetaryValueWithUSD:@0.0f]];
      });
    });

    context(@"when there is loyalty", ^{
      LUMerchant *merchant = [LUMerchant fakeInstance];

      it(@"is the loyalty's potential credit", ^{
        [[[merchant currentCredit] should] equal:merchant.loyalty.potentialCredit];
      });
    });
  });

  describe(@"imageURL", ^{
    NSURL *imageURL_1x = [NSURL URLWithString:@"http://example.com/image.png"];
    NSURL *imageURL_2x = [NSURL URLWithString:@"http://example.com/image@2x.png"];

    LUMerchant *merchant = [LUMerchant fakeInstanceWithImageURL_1x:imageURL_1x imageURL_2x:imageURL_2x];

    context(@"when the main screen scale is 1.0", ^{
      beforeEach(^{
        [[UIScreen mainScreen] stub:@selector(scale) andReturn:theValue(1.0)];
      });

      it(@"returns the imageURL at 1x", ^{
        [[[merchant imageURL] should] equal:imageURL_1x];
      });
    });

    context(@"when the main screen scale is 2.0", ^{
      beforeEach(^{
        [[UIScreen mainScreen] stub:@selector(scale) andReturn:theValue(2.0)];
      });

      it(@"returns the imageURL at 2x", ^{
        [[[merchant imageURL] should] equal:imageURL_2x];
      });
    });
  });

  describe(@"locationNearestTo:", ^{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:45 longitude:-70];

    context(@"when the merchant has no locations", ^{
      LUMerchant *merchant = [LUMerchant fakeInstanceWithNoLocations];

      it(@"is nil", ^{
        [[merchant locationNearestTo:location] shouldBeNil];
      });
    });

    context(@"when the merchant has locations", ^{
      LULocation *closeLocation = [[LULocation alloc] init];
      [closeLocation stub:@selector(latitude) andReturn:@46.0f];
      [closeLocation stub:@selector(longitude) andReturn:@-71.0f];

      LULocation *farLocation = [[LULocation alloc] init];
      [farLocation stub:@selector(latitude) andReturn:@-45.0f];
      [farLocation stub:@selector(longitude) andReturn:@-70.0f];

      LUMerchant *merchant = [LUMerchant fakeInstanceWithLocations:@[farLocation, closeLocation]];

      it(@"returns the location closest to the given location", ^{
        LULocation *nearestLocation = [merchant locationNearestTo:location];
        [[nearestLocation should] equal:closeLocation];
      });
    });
  });

  describe(@"twitterURL", ^{
    context(@"when the twitter username is blank", ^{
      LUMerchant *merchant = [LUMerchant fakeInstanceWithTwitterUsername:@""];

      it(@"is nil", ^{
        [[merchant twitterURL] shouldBeNil];
      });
    });

    context(@"when the twitter username is non-empty", ^{
      LUMerchant *merchant = [LUMerchant fakeInstanceWithTwitterUsername:@"TheLevelUp"];

      it(@"is the twitter URL for the username", ^{
        [[[merchant twitterURL] should] equal:[NSURL URLWithString:@"http://twitter.com/TheLevelUp"]];
      });
    });
  });

  describe(@"webLocations", ^{
    context(@"a merchant with web locations", ^{
      LUMerchant *merchant = [LUMerchant fakeInstanceWithWebLocations];

      it(@"returns an array of web service info dictionaries", ^{
        NSArray *webLocations = [merchant webLocations];

        [[webLocations should] haveCountOf:7];

        [[webLocations[0][@"service"] should] equal:MerchantWebService];
        [[webLocations[0][@"url"] should] equal:merchant.websiteURL];
        [webLocations[0][@"displayName"] shouldNotBeNil];

        [[webLocations[1][@"service"] should] equal:MerchantYelpService];
        [[webLocations[1][@"url"] should] equal:merchant.yelpURL];
        [webLocations[1][@"displayName"] shouldNotBeNil];

        [[webLocations[2][@"service"] should] equal:MerchantFacebookService];
        [[webLocations[2][@"url"] should] equal:merchant.facebookURL];
        [webLocations[2][@"displayName"] shouldNotBeNil];

        [[webLocations[3][@"service"] should] equal:MerchantTwitterService];
        [[webLocations[3][@"url"] should] equal:merchant.twitterURL];
        [webLocations[3][@"displayName"] shouldNotBeNil];

        [[webLocations[4][@"service"] should] equal:MerchantScvngrService];
        [[webLocations[4][@"url"] should] equal:merchant.scvngrURL];
        [webLocations[4][@"displayName"] shouldNotBeNil];

        [[webLocations[5][@"service"] should] equal:MerchantOpenTableService];
        [[webLocations[5][@"url"] should] equal:merchant.opentableURL];
        [webLocations[5][@"displayName"] shouldNotBeNil];

        [[webLocations[6][@"service"] should] equal:MerchantNewsletterService];
        [[webLocations[6][@"url"] should] equal:merchant.newsletterURL];
        [webLocations[6][@"displayName"] shouldNotBeNil];
      });
    });

    context(@"when one of the web locations is nil", ^{
      LUMerchant *merchant = [LUMerchant fakeInstanceWithTwitterUsername:@"TheLevelUp"];

      it(@"should not be included in webLocations", ^{
        [[theValue([merchant webLocations].count) should] equal:theValue(1)];
      });
    });
  });
});

SPEC_END
