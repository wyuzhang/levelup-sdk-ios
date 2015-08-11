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

#import "LUBaseLocation.h"

SPEC_BEGIN(LUBaseLocationSpec)

describe(@"LUBaseLocation", ^{
  // Helpers

  LUBaseLocation *(^baseLocationWithLatitudeLongitude)(NSNumber *latitude, NSNumber *longitude) = ^LUBaseLocation*(NSNumber *latitude, NSNumber *longitude) {
    return [[LUBaseLocation alloc] initWithExtendedAddress:nil latitude:latitude locality:nil
                                                 longitude:longitude postalCode:nil
                                                    region:nil streetAddress:nil];
  };

  it(@"is an LUAPIModel", ^{
    [[[LUBaseLocation class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Class Methods

  describe(@"baseLocations:sortedByDistanceFromLocation:", ^{
    context(@"when an input location is given", ^{
      it(@"return the array of LUBaseLocations sorted by ascending distance from the input location", ^{
        CLLocation *inputLocation = [[CLLocation alloc] initWithLatitude:1.0f longitude:1.0f];
        LUBaseLocation *farAddress = baseLocationWithLatitudeLongitude(@50, @50);
        LUBaseLocation *nearAddress = baseLocationWithLatitudeLongitude(@10, @10);

        NSArray *baseLocations = @[farAddress, nearAddress];

        NSArray *sortedLocations = [LUBaseLocation baseLocations:baseLocations sortedByDistanceFromLocation:inputLocation];

        [[sortedLocations[0] should] equal:nearAddress];
        [[sortedLocations[1] should] equal:farAddress];
      });
    });

    context(@"when no input location is given", ^{
      it(@"returns the array of LUBaseLocations sorted alphabetically by their street addresses", ^{
        LUBaseLocation *address1 = [[LUBaseLocation alloc] initWithExtendedAddress:nil latitude:@50 locality:nil
                                                                         longitude:@50 postalCode:nil
                                                                            region:nil streetAddress:@"Alpha st."];
        LUBaseLocation *address2 = [[LUBaseLocation alloc] initWithExtendedAddress:nil latitude:@10 locality:nil
                                                                         longitude:@10 postalCode:nil
                                                                            region:nil streetAddress:@"Beta st."];

        NSArray *baseLocations = @[address2, address1];

        NSArray *sortedLocations = [LUBaseLocation baseLocations:baseLocations sortedByDistanceFromLocation:nil];

        [[sortedLocations[0] should] equal:address1];
        [[sortedLocations[1] should] equal:address2];
      });
    });
  });

  // Public Methods

  describe(@"location", ^{
    context(@"when the location has a latitude and a longitude", ^{
      LUBaseLocation *baseLocation = baseLocationWithLatitudeLongitude(@-70, @45);

      it(@"returns a CLLocation for the associated location", ^{
        id result = [baseLocation location];
        [[result should] beKindOfClass:[CLLocation class]];

        CLLocation *clLocation = (CLLocation *)result;
        [[theValue(clLocation.coordinate.latitude) should] equal:baseLocation.latitude];
        [[theValue(clLocation.coordinate.longitude) should] equal:baseLocation.longitude];
      });
    });

    context(@"when the location doesn't have both a latitude and a longitude", ^{
      it(@"is nil", ^{
        LUBaseLocation *baseLocation = baseLocationWithLatitudeLongitude(nil, @45);

        [[baseLocation location] shouldBeNil];

        baseLocation = baseLocationWithLatitudeLongitude(@-70, nil);

        [[baseLocation location] shouldBeNil];
      });
    });
  });

  describe(@"coordinate", ^{
    context(@"when the location has a latitude and a longitude", ^{
      it(@"returns a CLLocationCoordinate2D for the associated location", ^{
        LUBaseLocation *baseLocation = baseLocationWithLatitudeLongitude(@-70, @45);

        CLLocationCoordinate2D result = [baseLocation coordinate];
        [[@(result.latitude) should] equal:baseLocation.latitude];
        [[@(result.longitude) should] equal:baseLocation.longitude];
      });

      it(@"bounds the latitude to [-90, 90]", ^{
        LUBaseLocation *baseLocation = baseLocationWithLatitudeLongitude(@-100, @45);

        [[theValue([baseLocation coordinate].latitude) should] equal:theValue(-90)];

        baseLocation = baseLocationWithLatitudeLongitude(@100, @45);

        [[theValue([baseLocation coordinate].latitude) should] equal:theValue(90)];
      });

      it(@"bounds the longitude to [-180, 180]", ^{
        LUBaseLocation *baseLocation = baseLocationWithLatitudeLongitude(@-70, @-200);

        [[theValue([baseLocation coordinate].longitude) should] equal:theValue(-180)];

        baseLocation = baseLocationWithLatitudeLongitude(@-70, @200);

        [[theValue([baseLocation coordinate].longitude) should] equal:theValue(180)];
      });
    });

    context(@"when the location doesn't have both a latitude and a longitude", ^{
      it(@"is kCLLocationCoordinate2DInvalid", ^{
        LUBaseLocation *baseLocation = baseLocationWithLatitudeLongitude(@-70, nil);

        [[theValue([baseLocation coordinate]) should] equal:theValue(kCLLocationCoordinate2DInvalid)];

        baseLocation = baseLocationWithLatitudeLongitude(nil, @45);

        [[theValue([baseLocation coordinate]) should] equal:theValue(kCLLocationCoordinate2DInvalid)];
      });
    });
  });
});

SPEC_END
