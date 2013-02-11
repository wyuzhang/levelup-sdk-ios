#import "LUDivision.h"

SPEC_BEGIN(LUDivisionSpec)

describe(@"LUDivision", ^{
  it(@"is an LUAPIModel", ^{
    [[[LUDivision class] should] beSubclassOfClass:[LUAPIModel class]];
  });

  // Public Methods

  __block LUDivision *division;

  beforeEach(^{
    division = [[LUDivision alloc] init];
  });

  describe(@"location", ^{
    context(@"when the division has a lat and a lng", ^{
      beforeEach(^{
        division.lat = @-70.0f;
        division.lng = @45.0f;
      });

      it(@"returns a CLLocation for the associated location", ^{
        id result = [division location];
        [[result should] beKindOfClass:[CLLocation class]];

        CLLocation *location = (CLLocation *)result;
        [[@(location.coordinate.latitude) should] equal:division.lat];
        [[@(location.coordinate.longitude) should] equal:division.lng];
      });
    });

    context(@"when the division doesn't have a lat or a lng", ^{
      it(@"is nil", ^{
        division.lat = @-70.0f;
        division.lng = nil;

        [[division location] shouldBeNil];

        division.lat = nil;
        division.lng = @45.0f;

        [[division location] shouldBeNil];
      });
    });
  });
});

SPEC_END
