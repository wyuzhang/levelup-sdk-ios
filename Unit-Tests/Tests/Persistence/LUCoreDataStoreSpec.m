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
        [[NSFileManager defaultManager] stub:@selector(fileExistsAtPath:)
                                   andReturn:theValue(YES)
                               withArguments:[[LUCoreDataStore storeDatabaseURL] path], nil];

        [[NSFileManager defaultManager] stub:@selector(attributesOfItemAtPath:error:)
                                   andReturn:@{NSFileCreationDate : [NSDate distantPast]}
                               withArguments:[[LUCoreDataStore storeDatabaseURL] path], nil, nil];

        [[NSFileManager defaultManager] stub:@selector(attributesOfItemAtPath:error:)
                                   andReturn:@{NSFileCreationDate : [NSDate date]}
                               withArguments:[[LUCoreDataStore initialDatabaseURL] path], nil, nil];
      });

      it(@"returns the store database URL without changing it", ^{
        [[[NSFileManager defaultManager] shouldNot] receive:@selector(removeItemAtURL:error:)];
        [[[NSFileManager defaultManager] shouldNot] receive:@selector(copyItemAtURL:toURL:error:)];

        [[[LUCoreDataStore storeURL] should] equal:[LUCoreDataStore storeDatabaseURL]];
      });
    });

    context(@"when the store database exists has the same creation time as the initial database", ^{
      beforeEach(^{
        [[NSFileManager defaultManager] stub:@selector(fileExistsAtPath:)
                                   andReturn:theValue(YES)
                               withArguments:[[LUCoreDataStore storeDatabaseURL] path], nil];

        NSDate *date = [NSDate date];
        [[NSFileManager defaultManager] stub:@selector(attributesOfItemAtPath:error:)
                                   andReturn:@{NSFileCreationDate : date}
                               withArguments:[[LUCoreDataStore storeDatabaseURL] path], nil, nil];

        [[NSFileManager defaultManager] stub:@selector(attributesOfItemAtPath:error:)
                                   andReturn:@{NSFileCreationDate : date}
                               withArguments:[[LUCoreDataStore initialDatabaseURL] path], nil, nil];
      });

      it(@"returns the store database URL without changing it", ^{
        [[[NSFileManager defaultManager] shouldNot] receive:@selector(removeItemAtURL:error:)];
        [[[NSFileManager defaultManager] shouldNot] receive:@selector(copyItemAtURL:toURL:error:)];

        [[[LUCoreDataStore storeURL] should] equal:[LUCoreDataStore storeDatabaseURL]];
      });
    });

    context(@"when the store database doesn't exist", ^{
      beforeEach(^{
        [[NSFileManager defaultManager] stub:@selector(fileExistsAtPath:)
                                   andReturn:theValue(NO)
                               withArguments:[[LUCoreDataStore storeDatabaseURL] path], nil];
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
        [[NSFileManager defaultManager] stub:@selector(fileExistsAtPath:)
                                   andReturn:theValue(YES)
                               withArguments:[[LUCoreDataStore storeDatabaseURL] path], nil];

        NSDate *date = [NSDate date];
        [[NSFileManager defaultManager] stub:@selector(attributesOfItemAtPath:error:)
                                   andReturn:@{NSFileCreationDate : date}
                               withArguments:[[LUCoreDataStore storeDatabaseURL] path], nil, nil];

        [[NSFileManager defaultManager] stub:@selector(attributesOfItemAtPath:error:)
                                   andReturn:@{NSFileCreationDate : [NSDate distantPast]}
                               withArguments:[[LUCoreDataStore initialDatabaseURL] path], nil, nil];
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
