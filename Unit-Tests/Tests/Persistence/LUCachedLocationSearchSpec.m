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
#import "LUCachedLocationSearch.h"
#import "LUCoreDataStack.h"
#import "NSManagedObjectContext+FakeContext.h"

SPEC_BEGIN(LUCachedLocationSearchSpec)

describe(@"LUCachedLocationSearch", ^{
  CLLocation *center = [[CLLocation alloc] initWithLatitude:0.0 longitude:0.0];
  NSUInteger limit = 2;

  __block NSManagedObjectContext *testManagedObjectContext;
  __block LUCachedLocationSearch *locationSearch;
  __block LUCachedLocation *location1, *location2, *location3;

  beforeEach(^{
    testManagedObjectContext = [NSManagedObjectContext fakeContext];
    [LUCoreDataStack stub:@selector(managedObjectContext) andReturn:testManagedObjectContext];

    location1 = [NSEntityDescription insertNewObjectForEntityForName:[LUCachedLocation entityName]
                                              inManagedObjectContext:testManagedObjectContext];
    location1.categoryIDs = @"1|2|";
    location1.locationID = @100;
    location1.latitude = @50;
    location1.longitude = @50;
    location1.shown = @YES;

    location2 = [NSEntityDescription insertNewObjectForEntityForName:[LUCachedLocation entityName]
                                              inManagedObjectContext:testManagedObjectContext];
    location2.categoryIDs = @"2|3|";
    location2.locationID = @2;
    location2.latitude = @10;
    location2.longitude = @10;
    location2.shown = @YES;

    location3 = [NSEntityDescription insertNewObjectForEntityForName:[LUCachedLocation entityName]
                                              inManagedObjectContext:testManagedObjectContext];
    location3.categoryIDs = @"1|";
    location3.locationID = @3;
    location3.latitude = @1;
    location3.longitude = @1;
    location3.shown = @YES;

    [testManagedObjectContext save:nil];

    locationSearch = [[LUCachedLocationSearch alloc] initWithCenter:center limit:limit categoryID:nil];
  });

  describe(@"executeSearch:", ^{
    context(@"when there are no locations", ^{
      beforeEach(^{
        [testManagedObjectContext deleteObject:location1];
        [testManagedObjectContext deleteObject:location2];
        [testManagedObjectContext deleteObject:location3];

        [testManagedObjectContext save:nil];
      });

      it(@"returns an empty array", ^{
        [[[locationSearch executeSearch:nil] should] equal:@[]];
      });
    });

    context(@"when there are fewer locations than the limit", ^{
      beforeEach(^{
        [testManagedObjectContext deleteObject:location2];
        [testManagedObjectContext deleteObject:location3];

        [testManagedObjectContext save:nil];
      });

      it(@"returns all the locations", ^{
        [[[locationSearch executeSearch:nil] should] equal:@[[location1 toLocation]]];
      });
    });

    context(@"when there are more locations than the limit", ^{
      it(@"finds locations near the center up to the limit, ordered by distance from the center", ^{
        NSArray *result = [locationSearch executeSearch:nil];

        NSArray *expected = @[[location3 toLocation], [location2 toLocation]];
        [[result should] equal:expected];
      });
    });

    context(@"when a category ID is provided", ^{
      beforeEach(^{
        locationSearch = [[LUCachedLocationSearch alloc] initWithCenter:center limit:limit categoryID:@1];
      });

      it(@"only returns locations matching the given category ID", ^{
        NSArray *result = [locationSearch executeSearch:nil];

        [[result should] containObjects:[location1 toLocation], [location3 toLocation], nil];
        [[result shouldNot] contain:[location2 toLocation]];
      });
    });
  });
});

SPEC_END
