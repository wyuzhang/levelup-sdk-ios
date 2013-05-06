#import "LUCachedLocation.h"

SPEC_BEGIN(LUCachedLocationSpec)

describe(@"LUCachedLocation", ^{
  __block NSManagedObjectContext *testManagedObjectContext;
  __block LUCachedLocation *testLocation;

  beforeEach(^{
    testManagedObjectContext = [NSManagedObjectContext testContext];

    testLocation = [NSEntityDescription insertNewObjectForEntityForName:[LUCachedLocation entityName] inManagedObjectContext:testManagedObjectContext];
    testLocation.categoryIDs = @"1|2|3|";
    testLocation.latitude = @40;
    testLocation.locationID = @1;
    testLocation.longitude = @-70;
    testLocation.merchantID = @2;
    testLocation.merchantName = @"Test Merchant";
    testLocation.shown = @YES;
    testLocation.updatedAtDate = [NSDate date];

    [testManagedObjectContext save:nil];
  });

  it(@"is an NSManagedObject", ^{
    [[[LUCachedLocation class] should] beSubclassOfClass:[NSManagedObject class]];
  });

  // Public Methods

  describe(@"entityName", ^{
    it(@"is 'Location'", ^{
      [[[LUCachedLocation entityName] should] equal:@"Location"];
    });
  });

  describe(@"findOrBuildWithLocationID:managedObjectContext", ^{
    context(@"when a LUCachedLocation with the given ID exists", ^{
      it(@"returns that LUCachedLocation", ^{
        LUCachedLocation *result = [LUCachedLocation findOrBuildWithLocationID:testLocation.locationID
                                                          managedObjectContext:testManagedObjectContext];

        [[result should] equal:testLocation];
      });
    });

    context(@"when there is no LUCachedLocation with the given ID", ^{
      it(@"inserts a new LUCachedLocation with that ID", ^{
        NSNumber *locationID = @2;
        LUCachedLocation *result = [LUCachedLocation findOrBuildWithLocationID:locationID
                                                          managedObjectContext:testManagedObjectContext];

        [[result.locationID should] equal:locationID];
        [[[testManagedObjectContext insertedObjects] should] haveCountOf:1];
      });
    });
  });

  describe(@"compare:relativeToLocation:", ^{
    CLLocation *referenceLocation = [[CLLocation alloc] initWithLatitude:41.0 longitude:-71.0];

    __block LUCachedLocation *comparisonLocation;

    beforeEach(^{
      comparisonLocation = [NSEntityDescription insertNewObjectForEntityForName:[LUCachedLocation entityName]
                                                         inManagedObjectContext:testManagedObjectContext];
      comparisonLocation.latitude = @30;
      comparisonLocation.longitude = @-80;
    });

    context(@"when the receiver is closer to the reference point than the argument", ^{
      it(@"returns NSOrderedAscending", ^{
        NSComparisonResult result = [testLocation compare:comparisonLocation relativeToLocation:referenceLocation];

        [[theValue(result) should] equal:theValue(NSOrderedAscending)];
      });
    });

    context(@"when the receiver is farther to the reference point", ^{
      it(@"returns NSOrderedDescending", ^{
        NSComparisonResult result = [comparisonLocation compare:testLocation relativeToLocation:referenceLocation];

        [[theValue(result) should] equal:theValue(NSOrderedDescending)];
      });
    });

    context(@"when the NSOrderedSame is the same distance from the reference point", ^{
      it(@"returns NSOrderedDescending", ^{
        NSComparisonResult result = [testLocation compare:testLocation relativeToLocation:referenceLocation];

        [[theValue(result) should] equal:theValue(NSOrderedSame)];
      });
    });
  });

  describe(@"toLocation", ^{
    it(@"returns a representation of the receiver as an LULocation", ^{
      LULocation *result = [testLocation toLocation];
      [[result should] beKindOfClass:[LULocation class]];
      [[result.categoryIDs should] equal:@[@1, @2, @3]];
      [[result.latitude should] equal:testLocation.latitude];
      [[result.locationID should] equal:testLocation.locationID];
      [[result.longitude should] equal:testLocation.longitude];
      [[result.merchantID should] equal:testLocation.merchantID];
      [[result.merchantName should] equal:testLocation.merchantName];
      [[@(result.shown) should] equal:testLocation.shown];
      [[result.updatedAtDate should] equal:testLocation.updatedAtDate];
    });
  });

  describe(@"updatePropertiesFromLocation:", ^{
    it(@"updates the receiver's properties using the given LULocation", ^{
      LULocation *location = [LULocation fakeInstance];
      [testLocation updatePropertiesFromLocation:location];

      [[testLocation.categoryIDs should] equal:@"1|2|"];
      [[testLocation.latitude should] equal:location.latitude];
      [[testLocation.locationID should] equal:location.locationID];
      [[testLocation.longitude should] equal:location.longitude];
      [[testLocation.merchantID should] equal:location.merchantID];
      [[testLocation.merchantName should] equal:location.merchantName];
      [[testLocation.shown should] equal:@(location.shown)];
      [[testLocation.updatedAtDate should] equal:location.updatedAtDate];
    });
  });
});

SPEC_END
