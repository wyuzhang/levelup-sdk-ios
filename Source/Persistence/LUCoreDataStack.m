#import "LUCoreDataStack.h"
#import "NSArray+LUAdditions.h"

NSString * const LUPersistedObjectsDefaultSqliteName = @"LUPersistedObjectsInitial";
NSString * const LUPersistedObjectsSqliteName = @"LUPersistedObjects";

@implementation LUCoreDataStack

#pragma mark - Public Methods

+ (NSManagedObjectContext *)managedObjectContext {
  NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
  managedObjectContext.persistentStoreCoordinator = [self persistentStoreCoordinator];

  return managedObjectContext;
}

+ (id)metadataStringForKey:(NSString *)key {
  NSManagedObjectContext *moc = [self managedObjectContext];
  return [self metadataForObjectContext:moc][key];
}

+ (void)setMetadataString:(NSString *)string forKey:(NSString *)key {
  NSManagedObjectContext *moc = [self managedObjectContext];
  NSMutableDictionary *metadata = [[self metadataForObjectContext:moc] mutableCopy];
  metadata[key] = string;
  [self setMetadata:metadata forObjectContext:moc];
}

#pragma mark - Private Methods

+ (NSDictionary *)metadataForObjectContext:(NSManagedObjectContext *)moc {
  return [[moc.persistentStoreCoordinator.persistentStores firstObject] metadata];
}

+ (void)setMetadata:(NSDictionary *)metadata forObjectContext:(NSManagedObjectContext *)moc {
  [[moc.persistentStoreCoordinator.persistentStores firstObject] setMetadata:metadata];
  [moc save:nil];
}

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
