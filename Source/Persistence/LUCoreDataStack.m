#import "LUCoreDataStack.h"

NSString * const LUPersistedObjectsDefaultSqliteName = @"LUPersistedObjectsInitial";
NSString * const LUPersistedObjectsSqliteName = @"LUPersistedObjects";

@implementation LUCoreDataStack

#pragma mark - Public Methods

+ (NSManagedObjectContext *)managedObjectContext {
  NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
  managedObjectContext.persistentStoreCoordinator = [self persistentStoreCoordinator];

  return managedObjectContext;
}

#pragma mark - Private Methods

+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  NSURL *storeURL = [self storeURL];

  if (![[NSFileManager defaultManager] fileExistsAtPath:[storeURL path]]) {
    NSURL *defaultStoreURL = [[NSBundle mainBundle] URLForResource:LUPersistedObjectsDefaultSqliteName withExtension:@"sqlite"];
    if (defaultStoreURL) {
      [[NSFileManager defaultManager] copyItemAtURL:defaultStoreURL toURL:storeURL error:nil];
    }
  }

  NSManagedObjectModel *mom = [NSManagedObjectModel mergedModelFromBundles:nil];
  NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];

  NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption : @YES, NSInferMappingModelAutomaticallyOption : @YES};
  NSError *error;
  if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                configuration:nil
                                                          URL:storeURL
                                                      options:options
                                                        error:&error]) {
    NSLog(@"Error while creating persistent store coordinator: %@, %@", error, [error userInfo]);
    abort();
  }

  return persistentStoreCoordinator;
}

+ (NSURL *)storeURL {
  NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];

  NSString *storeFileName = [LUPersistedObjectsSqliteName stringByAppendingPathExtension:@"sqlite"];
  return [applicationDocumentsDirectory URLByAppendingPathComponent:storeFileName];
}

@end
