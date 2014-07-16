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

#import "LUCachedLocation.h"
#import "NSManagedObjectContext+FakeContext.h"

SPEC_BEGIN(LUCachedLocationSpec)

describe(@"LUCachedLocation", ^{
  __block NSManagedObjectContext *testManagedObjectContext;
  __block LUCachedLocation *testLocation;

  beforeEach(^{
    testManagedObjectContext = [NSManagedObjectContext fakeContext];

    testLocation = [NSEntityDescription insertNewObjectForEntityForName:[LUCachedLocation entityName] inManagedObjectContext:testManagedObjectContext];
    testLocation.categoryIDs = @"1|2|3|";
    testLocation.latitude = @40;
    testLocation.locationID = @1;
    testLocation.longitude = @-70;
    testLocation.merchantID = @2;
    testLocation.merchantName = @"Test Merchant";
    testLocation.name = @"Test Name";
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

  describe(@"toCLLocation", ^{
    it(@"returns a representation of the receiver as a CLLocation", ^{
      CLLocation *result = [testLocation toCLLocation];
      [[result should] beKindOfClass:[CLLocation class]];
      [[theValue(result.coordinate.latitude) should] equal:theValue([testLocation.latitude doubleValue])];
      [[theValue(result.coordinate.longitude) should] equal:theValue([testLocation.longitude doubleValue])];
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
      [[result.name should] equal:testLocation.name];
      [[@(result.shown) should] equal:testLocation.shown];
      [[result.updatedAtDate should] equal:testLocation.updatedAtDate];
    });
  });

  describe(@"updatePropertiesFromLocation:", ^{
    it(@"updates the receiver's properties using the given LULocation", ^{
      LULocation *location = [LULocation fixture];
      [testLocation updatePropertiesFromLocation:location];

      [[testLocation.categoryIDs should] equal:@"1|2|"];
      [[testLocation.latitude should] equal:location.latitude];
      [[testLocation.locationID should] equal:location.locationID];
      [[testLocation.longitude should] equal:location.longitude];
      [[testLocation.merchantID should] equal:location.merchantID];
      [[testLocation.merchantName should] equal:location.merchantName];
      [[testLocation.name should] equal:location.name];
      [[testLocation.shown should] equal:@(location.shown)];
      [[testLocation.updatedAtDate should] equal:location.updatedAtDate];
    });
  });
});

SPEC_END
