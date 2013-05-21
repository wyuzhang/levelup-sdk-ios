#import "LUCoreDataStore.h"

NSString * const LUPersistedObjectsInitialDatabaseFileName = @"LUPersistedObjectsInitial";
NSString * const LUPersistedObjectsStoreDatabaseFileName = @"LUPersistedObjects";

@implementation LUCoreDataStore

#pragma mark - Public Methods

+ (NSURL *)storeURL {
  if (![self storeDatabaseExists] || [self initialDatabaseNewerThanStoreDatabase]) {
    [self replaceStoreDatabaseWithInitial];
  }

  return [self storeDatabaseURL];
}

#pragma mark - Private Methods (Database URLs)

+ (NSURL *)initialDatabaseURL {
  return [[NSBundle mainBundle] URLForResource:LUPersistedObjectsInitialDatabaseFileName withExtension:@"sqlite"];
}

+ (NSURL *)storeDatabaseURL {
  NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];

  NSString *storeFileName = [LUPersistedObjectsStoreDatabaseFileName stringByAppendingPathExtension:@"sqlite"];
  return [applicationDocumentsDirectory URLByAppendingPathComponent:storeFileName];
}

#pragma mark - Private Methods (Store File Access)

+ (NSDate *)fileCreatedAt:(NSURL *)file {
  NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[file path] error:nil];
  return attributes[NSFileCreationDate];
}

+ (BOOL)initialDatabaseNewerThanStoreDatabase {
  NSDate *storeDatabaseCreatedAt = [self fileCreatedAt:[self storeDatabaseURL]];
  NSDate *initialDatabaseCreatedAt = [self fileCreatedAt:[self initialDatabaseURL]];

  return [[storeDatabaseCreatedAt earlierDate:initialDatabaseCreatedAt] isEqualToDate:storeDatabaseCreatedAt];
}

+ (void)replaceStoreDatabaseWithInitial {
  if ([self storeDatabaseExists]) {
    [[NSFileManager defaultManager] removeItemAtURL:[self storeDatabaseURL] error:nil];
  }

  [[NSFileManager defaultManager] copyItemAtURL:[self initialDatabaseURL] toURL:[self storeDatabaseURL] error:nil];
}

+ (BOOL)storeDatabaseExists {
  return [[NSFileManager defaultManager] fileExistsAtPath:[[self storeDatabaseURL] path]];
}

@end
