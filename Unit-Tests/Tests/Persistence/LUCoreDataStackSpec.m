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

#import "LUCoreDataStack.h"
#import "LUCoreDataStore.h"
#import "NSArray+LUAdditions.h"
#import "NSManagedObjectContext+FakeContext.h"

SPEC_BEGIN(LUCoreDataStackSpec)

describe(@"LUCoreDataStack", ^{
  // Managed Object Context Methods

  describe(@"managedObjectContext", ^{
    __block NSPersistentStoreCoordinator *persistentStoreCoordinator;

    beforeEach(^{
      [LUCoreDataStore stub:@selector(storeURL) andReturn:[NSURL nullMock]];
      [NSManagedObjectModel stub:@selector(mergedModelFromBundles:) andReturn:[NSManagedObjectModel nullMock]];

      persistentStoreCoordinator = [NSPersistentStoreCoordinator nullMock];
      [NSPersistentStoreCoordinator stub:@selector(alloc) andReturn:persistentStoreCoordinator];
      [persistentStoreCoordinator stub:@selector(initWithManagedObjectModel:) andReturn:persistentStoreCoordinator];

      [persistentStoreCoordinator stub:@selector(addPersistentStoreWithType:configuration:URL:options:error:) andReturn:@YES];
    });

    it(@"returns a managed object context associated with the store database file", ^{
      KWCaptureSpy *spy = [persistentStoreCoordinator captureArgument:@selector(addPersistentStoreWithType:configuration:URL:options:error:)
                                                              atIndex:2];

      [LUCoreDataStack managedObjectContext];

      [[spy.argument should] equal:[LUCoreDataStore storeURL]];
    });
  });

  // Metadata Access

  describe(@"Metadata Access", ^{
    NSDictionary *metadata = @{@"key" : @"value"};
    __block NSPersistentStore *persistentStore;

    beforeEach(^{
      NSManagedObjectContext *testManagedObjectContext = [NSManagedObjectContext fakeContext];
      [LUCoreDataStack stub:@selector(managedObjectContext) andReturn:testManagedObjectContext];

      persistentStore = [testManagedObjectContext.persistentStoreCoordinator.persistentStores lu_firstObject];
      [persistentStore setMetadata:metadata];
      [testManagedObjectContext save:nil];
    });

    describe(@"metadataStringForKey:", ^{
      it(@"returns the metadata associated with the given key", ^{
        [[[LUCoreDataStack metadataStringForKey:@"key"] should] equal:metadata[@"key"]];
      });
    });

    describe(@"setMetadataString:forKey:", ^{
      it(@"updates the metadata with the given string set as the value of the key", ^{
        [LUCoreDataStack setMetadataString:@"newvalue" forKey:@"newkey"];

        NSDictionary *newMetadata = [persistentStore metadata];
        [[newMetadata[@"key"] should] equal:@"value"];
        [[newMetadata[@"newkey"] should] equal:@"newvalue"];
      });
    });
  });
});

SPEC_END
