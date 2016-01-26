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

#import "LULocation.h"
#import "NSURL+LUAdditions.h"

SPEC_BEGIN(LULocationSpec)

describe(@"LULocation", ^{
  it(@"is an LUAPIModel", ^{
    [[[LULocation class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  it(@"is an MKAnnotation", ^{
    [[[LULocation class] should] conformToProtocol:@protocol(MKAnnotation)];
  });

  // Creation

  describe(@"full initializer", ^{
    it(@"sets summary to NO", ^{
      LULocation *location = [[LULocation alloc] initWithCategoryIDs:nil categoryNames:nil deliveryMenuURL:nil
                                                     descriptionHTML:nil extendedAddress:nil hours:nil latitude:nil
                                                            locality:nil locationID:nil longitude:nil merchantID:nil
                                                        merchantName:nil name:nil phone:nil pickupMenuURL:nil
                                                          postalCode:nil region:nil shown:YES streetAddress:nil
                                                       updatedAtDate:nil webLocations:nil];

      [[theValue(location.summary) should] beNo];
    });
  });

  describe(@"summary initializer", ^{
    it(@"sets summary to YES", ^{
      LULocation *location = [[LULocation alloc] initWithCategoryIDs:nil latitude:nil locationID:nil longitude:nil
                                                          merchantID:nil merchantName:nil name:nil shown:NO
                                                       updatedAtDate:nil];

      [[theValue(location.summary) should] beYes];
    });
  });

  // Public Methods

  describe(@"imageURL", ^{
    LULocation *location = [LULocation fixtureWithLocationID:@1];
    NSURL *URL = [NSURL URLWithString:@"http://example.com/path/to/image"];

    beforeEach(^{
      [NSURL stub:@selector(lu_imageURLForLocationWithID:) andReturn:URL withArguments:@1, nil];
    });

    it(@"returns the URL of the location image request", ^{
      [[[location imageURL] should] equal:URL];
    });
  });

  // MKAnnotation Methods

  describe(@"subtitle", ^{
    it(@"is the name", ^{
      LULocation *location = [LULocation fixture];

      [[[location subtitle] should] equal:location.name];
    });
  });

  describe(@"title", ^{
    it(@"is the merchantName", ^{
      LULocation *location = [LULocation fixture];

      [[[location title] should] equal:location.merchantName];
    });
  });
});

SPEC_END
