#import "LUCoreDataStack.h"
#import "NSArray+LUAdditions.h"

SPEC_BEGIN(LUCoreDataStackSpec)

describe(@"LUCoreDataStack", ^{
  // Managed Object Context Methods

  describe(@"managedObjectContext", ^{
    __block NSPersistentStoreCoordinator *persistentStoreCoordinator;

    beforeEach(^{
      [NSManagedObjectModel stub:@selector(mergedModelFromBundles:) andReturn:[NSManagedObjectModel nullMock]];
      [NSBundle stub:@selector(mainBundle) andReturn:[NSBundle bundleForClass:[LUCoreDataStack class]]];

      persistentStoreCoordinator = [NSPersistentStoreCoordinator nullMock];
      [NSPersistentStoreCoordinator stub:@selector(alloc) andReturn:persistentStoreCoordinator];
      [persistentStoreCoordinator stub:@selector(initWithManagedObjectModel:) andReturn:persistentStoreCoordinator];

      [persistentStoreCoordinator stub:@selector(addPersistentStoreWithType:configuration:URL:options:error:) andReturn:@YES];
    });

    it(@"returns a managed object context associated with the store database file", ^{
      KWCaptureSpy *spy = [persistentStoreCoordinator captureArgument:@selector(addPersistentStoreWithType:configuration:URL:options:error:)
                                                              atIndex:2];

      [LUCoreDataStack managedObjectContext];

      [[spy.argument should] equal:[LUCoreDataStack storeDatabaseURL]];
    });

    context(@"when the store database doesn't exist", ^{
      beforeEach(^{
        [[[NSFileManager defaultManager] stubAndReturn:theValue(NO)] fileExistsAtPath:[[LUCoreDataStack storeDatabaseURL] path]];
      });

      it(@"copies the initial database to the store database", ^{
        [[[[NSFileManager defaultManager] should] receive] copyItemAtURL:[LUCoreDataStack initialDatabaseURL]
                                                                   toURL:[LUCoreDataStack storeDatabaseURL]
                                                                   error:nil];

        [LUCoreDataStack managedObjectContext];
      });
    });

    context(@"when the initial database is newer than the store database", ^{
      beforeEach(^{
        [[[NSFileManager defaultManager] stubAndReturn:@YES] fileExistsAtPath:[[LUCoreDataStack storeDatabaseURL] path]];

        [[[NSFileManager defaultManager] stubAndReturn:@{NSFileCreationDate : [NSDate distantPast]}] attributesOfItemAtPath:[[LUCoreDataStack storeDatabaseURL] path]
                                                                                                                      error:nil];
        [[[NSFileManager defaultManager] stubAndReturn:@{NSFileCreationDate : [NSDate date]}] attributesOfItemAtPath:[[LUCoreDataStack initialDatabaseURL] path]
                                                                                                               error:nil];
      });

      it(@"replaces the store database with the initial database", ^{
        [[[[NSFileManager defaultManager] should] receive] removeItemAtURL:[LUCoreDataStack storeDatabaseURL]
                                                                     error:nil];

        [[[[NSFileManager defaultManager] should] receive] copyItemAtURL:[LUCoreDataStack initialDatabaseURL]
                                                                   toURL:[LUCoreDataStack storeDatabaseURL]
                                                                   error:nil];

        [LUCoreDataStack managedObjectContext];
      });
    });
  });

  // Metadata Access

  describe(@"Metadata Access", ^{
    NSDictionary *metadata = @{@"key" : @"value"};
    __block NSPersistentStore *persistentStore;

    beforeEach(^{
      NSManagedObjectContext *testManagedObjectContext = [NSManagedObjectContext testContext];
      [LUCoreDataStack stub:@selector(managedObjectContext) andReturn:testManagedObjectContext];

      persistentStore = [testManagedObjectContext.persistentStoreCoordinator.persistentStores firstObject];
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
