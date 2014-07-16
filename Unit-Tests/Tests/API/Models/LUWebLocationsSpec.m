/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

SPEC_BEGIN(LUWebLocationsSpec)

describe(@"LUWebLocation", ^{
  __block LUWebLocations *webLocations;
  NSString *facebookAddress = @"http://facebook.com/example";
  NSString *foodlerAddress = @"http://foodler.com/example";
  NSString *menuAddress = @"http://menu.com/example";
  NSString *newsletterAddress = @"http://newsletter.com/example";
  NSString *opentableAddress = @"http://opentable.com/example";
  NSString *twitterAddress = @"http://twitter.com/example";
  NSString *yelpAddress = @"http://yelp.com/example";

  beforeAll(^{
    webLocations = [[LUWebLocations alloc] initWithFacebookAddress:facebookAddress foodlerAddress:foodlerAddress
                                                       menuAddress:menuAddress newsletterAddress:newsletterAddress
                                                  opentableAddress:opentableAddress twitterAddress:twitterAddress
                                                       yelpAddress:yelpAddress];
  });

  describe(@"facebookURL", ^{
    it(@"Returns an NSURL created with the supplied facebook addressURL", ^{
      [[[webLocations facebookURL] should] equal:[NSURL URLWithString:facebookAddress]];
    });
  });

  describe(@"foodlerURL", ^{
    it(@"Returns an NSURL created with the supplied foodler addressURL", ^{
      [[[webLocations foodlerURL] should] equal:[NSURL URLWithString:foodlerAddress]];
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
