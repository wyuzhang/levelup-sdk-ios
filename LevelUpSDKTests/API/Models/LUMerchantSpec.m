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

  __block LUMerchant *merchant;

  beforeEach(^{
    merchant = [[LUMerchant alloc] init];
  });

  describe(@"categoryImageUrl", ^{
    beforeEach(^{
      merchant.categoryImageUrl_32x32_1x = @"categoryImage_1x";
      merchant.categoryImageUrl_32x32_2x = @"categoryImage_2x";
    });

    context(@"when the main screen scale is 1.0", ^{
      beforeEach(^{
        [[UIScreen mainScreen] stub:@selector(scale) andReturn:theValue(1.0)];
      });

      it(@"returns the categoryImageUrl at 1x", ^{
        [[[merchant categoryImageUrl] should] equal:merchant.categoryImageUrl_32x32_1x];
      });
    });

    context(@"when the main screen scale is 2.0", ^{
      beforeEach(^{
        [[UIScreen mainScreen] stub:@selector(scale) andReturn:theValue(2.0)];
      });

      it(@"returns the categoryImageUrl at 2x", ^{
        [[[merchant categoryImageUrl] should] equal:merchant.categoryImageUrl_32x32_2x];
      });
    });
  });

  describe(@"currentCredit", ^{
    context(@"when there is no loyalty", ^{
      beforeEach(^{
        merchant.loyalty = nil;
      });

      it(@"is $0", ^{
        LUMonetaryValue *currentCredit = [merchant currentCredit];

        [[currentCredit should] equal:[LUMonetaryValue monetaryValueWithUSD:@0.0f]];
      });
    });

    context(@"when there is loyalty", ^{
      beforeEach(^{
        merchant.loyalty = [[LULoyalty alloc] init];
        merchant.loyalty.potentialCredit = [LUMonetaryValue monetaryValueWithUSD:@5.0f];
      });

      it(@"is the loyalty's potential credit", ^{
        LUMonetaryValue *currentCredit = [merchant currentCredit];

        [[currentCredit should] equal:merchant.loyalty.potentialCredit];
      });
    });
  });

  describe(@"imageUrl", ^{
    beforeEach(^{
      merchant.imageUrl_280x128_1x = @"image_1x";
      merchant.imageUrl_280x128_2x = @"image_2x";
    });

    context(@"when the main screen scale is 1.0", ^{
      beforeEach(^{
        [[UIScreen mainScreen] stub:@selector(scale) andReturn:theValue(1.0)];
      });

      it(@"returns the imageUrl at 1x", ^{
        [[[merchant imageUrl] should] equal:merchant.imageUrl_280x128_1x];
      });
    });

    context(@"when the main screen scale is 2.0", ^{
      beforeEach(^{
        [[UIScreen mainScreen] stub:@selector(scale) andReturn:theValue(2.0)];
      });

      it(@"returns the imageUrl at 2x", ^{
        [[[merchant imageUrl] should] equal:merchant.imageUrl_280x128_2x];
      });
    });
  });

  describe(@"locationNearestTo:", ^{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:45 longitude:-70];

    context(@"when the merchant has no locations", ^{
      it(@"is nil", ^{
        merchant.locations = nil;
        [[merchant locationNearestTo:location] shouldBeNil];

        merchant.locations = @[];
        [[merchant locationNearestTo:location] shouldBeNil];
      });
    });

    context(@"when the merchant has locations", ^{
      it(@"returns the location closest to the given location", ^{
        LULocation *closeLocation = [[LULocation alloc] init];
        closeLocation.lat = @46.0f;
        closeLocation.lng = @-71.0f;

        LULocation *farLocation = [[LULocation alloc] init];
        farLocation.lat = @-45.0f;
        farLocation.lng = @-70.0f;

        merchant.locations = @[farLocation, closeLocation];

        LULocation *nearestLocation = [merchant locationNearestTo:location];
        [[nearestLocation should] equal:closeLocation];
      });
    });
  });

  describe(@"twitterUrl", ^{
    context(@"when the twitter username is blank", ^{
      beforeEach(^{
        merchant.twitterUsername = @"";
      });

      it(@"is nil", ^{
        [[merchant twitterUrl] shouldBeNil];
      });

      context(@"when the twitter username is non-empty", ^{
        beforeEach(^{
          merchant.twitterUsername = @"TheLevelUp";
        });

        it(@"is the twitter URL for the username", ^{
          [[[merchant twitterUrl] should] equal:@"http://twitter.com/TheLevelUp"];
        });
      });
    });
  });

  describe(@"webLocations", ^{
    beforeEach(^{
      merchant.url = @"http://example.com";
      merchant.yelpUrl  = @"http://yelp.com/example";
      merchant.facebookUrl = @"http://facebook.com/example";
      merchant.twitterUsername = @"example";
      merchant.scvngrUrl = @"http://scvngr.com/example";
      merchant.opentableUrl  = @"http://opentable.com/example";
      merchant.newsletterUrl = @"http://example.com/newsletter";
    });

    it(@"returns an array of web service info dictionaries", ^{
      NSArray *webLocations = [merchant webLocations];

      [[webLocations should] haveCountOf:7];

      [[webLocations[0][@"service"] should] equal:MerchantWebService];
      [[webLocations[0][@"url"] should] equal:merchant.url];
      [webLocations[0][@"displayName"] shouldNotBeNil];

      [[webLocations[1][@"service"] should] equal:MerchantYelpService];
      [[webLocations[1][@"url"] should] equal:merchant.yelpUrl];
      [webLocations[1][@"displayName"] shouldNotBeNil];

      [[webLocations[2][@"service"] should] equal:MerchantFacebookService];
      [[webLocations[2][@"url"] should] equal:merchant.facebookUrl];
      [webLocations[2][@"displayName"] shouldNotBeNil];

      [[webLocations[3][@"service"] should] equal:MerchantTwitterService];
      [[webLocations[3][@"url"] should] equal:merchant.twitterUrl];
      [webLocations[3][@"displayName"] shouldNotBeNil];

      [[webLocations[4][@"service"] should] equal:MerchantScvngrService];
      [[webLocations[4][@"url"] should] equal:merchant.scvngrUrl];
      [webLocations[4][@"displayName"] shouldNotBeNil];

      [[webLocations[5][@"service"] should] equal:MerchantOpenTableService];
      [[webLocations[5][@"url"] should] equal:merchant.opentableUrl];
      [webLocations[5][@"displayName"] shouldNotBeNil];

      [[webLocations[6][@"service"] should] equal:MerchantNewsletterService];
      [[webLocations[6][@"url"] should] equal:merchant.newsletterUrl];
      [webLocations[6][@"displayName"] shouldNotBeNil];
    });

    context(@"when one of the web locations is blank", ^{
      it(@"should not be included in webLocations", ^{
        merchant = [[LUMerchant alloc] init];
        merchant.url = @"";
        merchant.yelpUrl = @"http://yelp.com/example";

        [[theValue([merchant webLocations].count) should] equal:theValue(1)];
      });
    });
  });
});

SPEC_END
