SPEC_BEGIN(LUWebLocationsSpec)

describe(@"LUWebLocation", ^{
  __block LUWebLocations *webLocations;
  NSString *facebookAddress = @"http://facebook.com/example";
  NSString *menuAddress = @"http://menu.com/example";
  NSString *newsletterAddress = @"http://newsletter.com/example";
  NSString *opentableAddress = @"http://opentable.com/example";
  NSString *twitterAddress = @"http://twitter.com/example";
  NSString *yelpAddress = @"http://yelp.com/example";

  beforeAll(^{
    webLocations = [[LUWebLocations alloc] initWithFacebookAddress:facebookAddress menuAddress:menuAddress newsletterAddress:newsletterAddress opentableAddress:opentableAddress twitterAddress:twitterAddress yelpAddress:yelpAddress];
  });

  describe(@"facebookURL", ^{
    it(@"Returns an NSURL created with the supplied facebook addressURL", ^{
      [[[webLocations facebookURL] should] equal:[NSURL URLWithString:facebookAddress]];
    });
  });

  describe(@"menuURL", ^{
    it(@"returns an NSURL created with the supplied menu addressURL", ^{
      [[[webLocations menuURL] should] equal:[NSURL URLWithString:menuAddress]];
    });
  });

  describe(@"newsletterURL", ^{
    it(@"returns an NSURL created with the supplied newsletter addressURL", ^{
      [[[webLocations newsletterURL] should] equal:[NSURL URLWithString:newsletterAddress]];
    });
  });

  describe(@"opentableURL", ^{
    it(@"returns an NSURL created with the supplied opentable address", ^{
      [[[webLocations opentableURL] should] equal:[NSURL URLWithString:opentableAddress]];
    });
  });

  describe(@"twitterURL", ^{
    it(@"returns an NSURL created with the supplied twitter address", ^{
      [[[webLocations twitterURL] should] equal:[NSURL URLWithString:twitterAddress]];
    });
  });

  describe(@"yelpURL", ^{
    it(@"returns an NSURL created with the supplied twitter address", ^{
      [[[webLocations yelpURL] should] equal:[NSURL URLWithString:yelpAddress]];
    });
  });
});

SPEC_END
