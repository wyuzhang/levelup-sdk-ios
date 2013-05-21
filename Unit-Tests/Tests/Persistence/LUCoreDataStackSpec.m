#import "LUCoreDataStack.h"
#import "LUCoreDataStore.h"
#import "NSArray+LUAdditions.h"

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
