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

#import "LULocationJSONFactory.h"
#import "NSDate+StringFormats.h"

SPEC_BEGIN(LULocationJSONFactorySpec)

describe(@"LULocationJSONFactory", ^{
  __block LULocationJSONFactory *factory;

  beforeEach(^{
    factory = [LULocationJSONFactory factory];
  });

  describe(@"createFromAttributes:", ^{
    it(@"parses a JSON dictionary into an LULocation", ^{
      NSDictionary *JSON = @{
        @"categories" : @[@1, @2, @3],
        @"category_names" : @[@"American", @"Breakfast", @"Cafe"],
        @"description_html" : @"pizza, pizza, pizza!",
        @"extended_address" : @"Apt E",
        @"facebook_url" : @"http://facebook.com/pizza",
        @"foodler_url" : @"http://foodler.com/pizza",
        @"hours" : @"M-F 9am-5pm",
        @"id" : @1,
        @"latitude" : @70,
        @"locality" : @"Boston",
        @"longitude" : @-45,
        @"menu_url" : @"http://pizza.com/menu",
        @"merchant_id" : @1,
        @"merchant_name" : @"Dewey, Cheatem and Howe",
        @"name" : @"Test Location",
        @"newsletter_url" : @"http://pizza.com/newsletter",
        @"opentable_url" : @"http://opentable.com/pizza",
        @"phone" : @"617-123-1234",
        @"postal_code" : @"01234",
        @"region" : @"MA",
        @"shown" : @1,
        @"street_address" : @"1 Main St",
        @"twitter_url" : @"http://twitter.com/pizza",
        @"updated_at" : @"2012-12-04T18:10:45-05:00",
        @"yelp_url" : @"http://yelp.com/pizza"
      };
      LULocation *location = [factory createFromAttributes:JSON];

      [[location.categoryIDs should] equal:@[@1, @2, @3]];
      [[location.categoryNames should] equal:@[@"American", @"Breakfast", @"Cafe"]];
      [[location.descriptionHTML should] equal:@"pizza, pizza, pizza!"];
      [[location.extendedAddress should] equal:@"Apt E"];
      [[location.hours should] equal:@"M-F 9am-5pm"];
      [[location.latitude should] equal:@70];
      [[location.locality should] equal:@"Boston"];
      [[location.locationID should] equal:@1];
      [[location.longitude should] equal:@-45];
      [[location.merchantID should] equal:@1];
      [[location.merchantName should] equal:@"Dewey, Cheatem and Howe"];
      [[location.name should] equal:@"Test Location"];
      [[location.phone should] equal:@"617-123-1234"];
      [[location.postalCode should] equal:@"01234"];
      [[location.region should] equal:@"MA"];
      [[theValue(location.shown) should] beYes];
      [[location.streetAddress should] equal:@"1 Main St"];
      [[theValue(location.summary) should] beNo];
      [[[location.webLocations facebookURL] should] equal:[NSURL URLWithString:@"http://facebook.com/pizza"]];
      [[[location.webLocations foodlerURL] should] equal:[NSURL URLWithString:@"http://foodler.com/pizza"]];
      [[[location.webLocations menuURL] should] equal:[NSURL URLWithString:@"http://pizza.com/menu"]];
      [[[location.webLocations newsletterURL] should] equal:[NSURL URLWithString:@"http://pizza.com/newsletter"]];
      [[[location.webLocations opentableURL] should] equal:[NSURL URLWithString:@"http://opentable.com/pizza"]];
      [[[location.webLocations twitterURL] should] equal:[NSURL URLWithString:@"http://twitter.com/pizza"]];
      [[[location.webLocations yelpURL] should] equal:[NSURL URLWithString:@"http://yelp.com/pizza"]];
      [[location.updatedAtDate should] equal:[NSDate lu_dateFromIso8601DateTimeString:@"2012-12-04T18:10:45-05:00"]];
    });
  });

  describe(@"rootKey", ^{
    it(@"is 'location'", ^{
      [[[factory rootKey] should] equal:@"location"];
    });
  });
});

SPEC_END
