// Copyright 2013 SCVNGR, Inc., D.B.A. LevelUp. All rights reserved.

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
      LULocation *location = [[LULocation alloc] initWithCategoryIDs:nil descriptionHTML:nil extendedAddress:nil hours:nil latitude:nil
                                                            locality:nil locationID:nil longitude:nil merchantID:nil
                                                        merchantName:nil name:nil phone:nil postalCode:nil
                                                              region:nil shown:YES streetAddress:nil updatedAtDate:nil webLocations:nil];

      [[theValue(location.summary) should] beNo];
    });
  });

  describe(@"summary initializer", ^{
    it(@"sets summary to YES", ^{
      LULocation *location = [[LULocation alloc] initWithCategoryIDs:nil latitude:nil locationID:nil longitude:nil
                                                          merchantID:nil merchantName:nil shown:NO updatedAtDate:nil];

      [[theValue(location.summary) should] beYes];
    });
  });

  // Public Methods

  describe(@"fullStreetAddress", ^{
    context(@"when the location has a streetAddress and an extendedAddress", ^{
      LULocation *location = [LULocation fixture];

      it(@"is the street address combined with the extended address", ^{
        NSString *expected = [NSString stringWithFormat:@"%@, %@", location.streetAddress,
                              location.extendedAddress];
        [[[location fullStreetAddress] should] equal:expected];
      });
    });

    context(@"when the location only has a streetAddress", ^{
      LULocation *location = [LULocation fixtureWithNoExtendedAddress];

      it(@"is the street address", ^{
        [[[location fullStreetAddress] should] equal:location.streetAddress];
      });
    });
  });

  describe(@"imageURL", ^{
    LULocation *location = [LULocation fixtureWithLocationID:@1];
    NSURL *URL = [NSURL URLWithString:@"http://example.com/path/to/image"];

    beforeEach(^{
      [NSURL stub:@selector(lu_imageURLForLocationWithID:) andReturn:URL withArguments:@1];
    });

    it(@"returns the URL of the location image request", ^{
      [[[location imageURL] should] equal:URL];
    });
  });

  describe(@"location", ^{
    context(@"when the location has a latitude and a longitude", ^{
      LULocation *location = [LULocation fixtureWithLatitude:@-70.0f longitude:@45.0f];

      it(@"returns a CLLocation for the associated location", ^{
        id result = [location location];
        [[result should] beKindOfClass:[CLLocation class]];

        CLLocation *clLocation = (CLLocation *)result;
        [[theValue(clLocation.coordinate.latitude) should] equal:location.latitude];
        [[theValue(clLocation.coordinate.longitude) should] equal:location.longitude];
      });
    });

    context(@"when the location doesn't have both a latitude and a longitude", ^{
      it(@"is nil", ^{
        LULocation *location = [LULocation fixtureWithLatitude:@-70.0f longitude:nil];
        [[location location] shouldBeNil];

        location = [LULocation fixtureWithLatitude:nil longitude:@45.0f];
        [[location location] shouldBeNil];
      });
    });
  });

  describe(@"singleLineAddress", ^{
    LULocation *location = [LULocation fixture];

    it(@"is combination of all the address elements", ^{
      NSString *expected = [NSString stringWithFormat:@"%@, %@, %@, %@ %@",
                            location.streetAddress, location.extendedAddress, location.locality,
                            location.region, location.postalCode];

      [[[location singleLineAddress] should] equal:expected];
    });
  });

  // MKAnnotation Methods

  describe(@"coordinate", ^{
    context(@"when the location has a latitude and a longitude", ^{
      it(@"returns a CLLocationCoordinate2D for the associated location", ^{
        LULocation *location = [LULocation fixtureWithLatitude:@-70.0f longitude:@45.0f];

        CLLocationCoordinate2D result = [location coordinate];
        [[@(result.latitude) should] equal:location.latitude];
        [[@(result.longitude) should] equal:location.longitude];
      });

      it(@"bounds the latitude to [-90, 90]", ^{
        LULocation *location = [LULocation fixtureWithLatitude:@-100.0f longitude:@45.0f];
        [[theValue([location coordinate].latitude) should] equal:theValue(-90)];

        location = [LULocation fixtureWithLatitude:@100.0f longitude:@45.0f];
        [[theValue([location coordinate].latitude) should] equal:theValue(90)];
      });

      it(@"bounds the longitude to [-180, 180]", ^{
        LULocation *location = [LULocation fixtureWithLatitude:@-70.0f longitude:@-200.0f];
        [[theValue([location coordinate].longitude) should] equal:theValue(-180)];

        location = [LULocation fixtureWithLatitude:@-70.0f longitude:@200.0f];
        [[theValue([location coordinate].longitude) should] equal:theValue(180)];
      });

      context(@"when the location doesn't have both a latitude and a longitude", ^{
        it(@"is kCLLocationCoordinate2DInvalid", ^{
          LULocation *location = [LULocation fixtureWithLatitude:@-70.0f longitude:nil];
          [[theValue([location coordinate]) should] equal:theValue(kCLLocationCoordinate2DInvalid)];

          location = [LULocation fixtureWithLatitude:nil longitude:@45.0f];
          [[theValue([location coordinate]) should] equal:theValue(kCLLocationCoordinate2DInvalid)];
        });
      });
    });
  });

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
