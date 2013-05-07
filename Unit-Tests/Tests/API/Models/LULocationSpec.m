#import "LULocation.h"

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
      LULocation *location = [LULocation fakeInstance];

      it(@"is the street address combined with the extended address", ^{
        NSString *expected = [NSString stringWithFormat:@"%@, %@", location.streetAddress,
                              location.extendedAddress];
        [[[location fullStreetAddress] should] equal:expected];
      });
    });

    context(@"when the location only has a streetAddress", ^{
      LULocation *location = [LULocation fakeInstanceWithNoExtendedAddress];

      it(@"is the street address", ^{
        [[[location fullStreetAddress] should] equal:location.streetAddress];
      });
    });
  });

  describe(@"location", ^{
    context(@"when the location has a latitude and a longitude", ^{
      LULocation *location = [LULocation fakeInstanceWithLatitude:@-70.0f longitude:@45.0f];

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
        LULocation *location = [LULocation fakeInstanceWithLatitude:@-70.0f longitude:nil];
        [[location location] shouldBeNil];

        location = [LULocation fakeInstanceWithLatitude:nil longitude:@45.0f];
        [[location location] shouldBeNil];
      });
    });
  });

  describe(@"singleLineAddress", ^{
    LULocation *location = [LULocation fakeInstance];

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
        LULocation *location = [LULocation fakeInstanceWithLatitude:@-70.0f longitude:@45.0f];

        CLLocationCoordinate2D result = [location coordinate];
        [[@(result.latitude) should] equal:location.latitude];
        [[@(result.longitude) should] equal:location.longitude];
      });

      it(@"bounds the latitude to [-90, 90]", ^{
        LULocation *location = [LULocation fakeInstanceWithLatitude:@-100.0f longitude:@45.0f];
        [[theValue([location coordinate].latitude) should] equal:theValue(-90)];

        location = [LULocation fakeInstanceWithLatitude:@100.0f longitude:@45.0f];
        [[theValue([location coordinate].latitude) should] equal:theValue(90)];
      });

      it(@"bounds the longitude to [-180, 180]", ^{
        LULocation *location = [LULocation fakeInstanceWithLatitude:@-70.0f longitude:@-200.0f];
        [[theValue([location coordinate].longitude) should] equal:theValue(-180)];

        location = [LULocation fakeInstanceWithLatitude:@-70.0f longitude:@200.0f];
        [[theValue([location coordinate].longitude) should] equal:theValue(180)];
      });

      context(@"when the location doesn't have both a latitude and a longitude", ^{
        it(@"is kCLLocationCoordinate2DInvalid", ^{
          LULocation *location = [LULocation fakeInstanceWithLatitude:@-70.0f longitude:nil];
          [[theValue([location coordinate]) should] equal:theValue(kCLLocationCoordinate2DInvalid)];

          location = [LULocation fakeInstanceWithLatitude:nil longitude:@45.0f];
          [[theValue([location coordinate]) should] equal:theValue(kCLLocationCoordinate2DInvalid)];
        });
      });
    });
  });

  describe(@"title", ^{
    it(@"is the fullStreetAddress", ^{
      LULocation *location = [LULocation fakeInstance];
      [location stub:@selector(fullStreetAddress) andReturn:@"123 Main St"];

      [[[location title] should] equal:[location fullStreetAddress]];
    });
  });
});

SPEC_END
