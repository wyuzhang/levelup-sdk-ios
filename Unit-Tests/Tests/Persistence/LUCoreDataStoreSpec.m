#import "LUCoreDataStore.h"

@interface LUCoreDataStore (DatabaseURLs)

+ (NSURL *)initialDatabaseURL;
+ (NSURL *)storeDatabaseURL;

@end

SPEC_BEGIN(LUCoreDataStoreSpec)

describe(@"LUCoreDataStore", ^{
  describe(@"storeURL", ^{
    context(@"when the store database exists and is newer than the initial database", ^{
      beforeEach(^{
        [[[NSFileManager defaultManager] stubAndReturn:@YES] fileExistsAtPath:[[LUCoreDataStore storeDatabaseURL] path]];

        [[[NSFileManager defaultManager] stubAndReturn:@{NSFileCreationDate : [NSDate date]}] attributesOfItemAtPath:[[LUCoreDataStore storeDatabaseURL] path]
                                                                                                               error:nil];
        [[[NSFileManager defaultManager] stubAndReturn:@{NSFileCreationDate : [NSDate distantPast]}] attributesOfItemAtPath:[[LUCoreDataStore initialDatabaseURL] path]
                                                                                                                      error:nil];
      });

      it(@"returns the store database URL without changing it", ^{
        [[[NSFileManager defaultManager] shouldNot] receive:@selector(removeItemAtURL:error:)];
        [[[NSFileManager defaultManager] shouldNot] receive:@selector(copyItemAtURL:toURL:error:)];

        [[[LUCoreDataStore storeURL] should] equal:[LUCoreDataStore storeDatabaseURL]];
      });
    });

    context(@"when the store database doesn't exist", ^{
      beforeEach(^{
        [[[NSFileManager defaultManager] stubAndReturn:theValue(NO)] fileExistsAtPath:[[LUCoreDataStore storeDatabaseURL] path]];
      });

      it(@"copies the initial database to the store database", ^{
        [[[[NSFileManager defaultManager] should] receive] copyItemAtURL:[LUCoreDataStore initialDatabaseURL]
                                                                   toURL:[LUCoreDataStore storeDatabaseURL]
                                                                   error:nil];

        [[[LUCoreDataStore storeURL] should] equal:[LUCoreDataStore storeDatabaseURL]];
      });
    });

    context(@"when the initial database is newer than the store database", ^{
      beforeEach(^{
        [[[NSFileManager defaultManager] stubAndReturn:@YES] fileExistsAtPath:[[LUCoreDataStore storeDatabaseURL] path]];

        [[[NSFileManager defaultManager] stubAndReturn:@{NSFileCreationDate : [NSDate distantPast]}] attributesOfItemAtPath:[[LUCoreDataStore storeDatabaseURL] path]
                                                                                                                      error:nil];
        [[[NSFileManager defaultManager] stubAndReturn:@{NSFileCreationDate : [NSDate date]}] attributesOfItemAtPath:[[LUCoreDataStore initialDatabaseURL] path]
                                                                                                               error:nil];
      });

      it(@"replaces the store database with the initial database", ^{
        [[[[NSFileManager defaultManager] should] receive] removeItemAtURL:[LUCoreDataStore storeDatabaseURL]
                                                                     error:nil];

        [[[[NSFileManager defaultManager] should] receive] copyItemAtURL:[LUCoreDataStore initialDatabaseURL]
                                                                   toURL:[LUCoreDataStore storeDatabaseURL]
                                                                   error:nil];

        [[[LUCoreDataStore storeURL] should] equal:[LUCoreDataStore storeDatabaseURL]];
      });
    });
  });
});

SPEC_END
