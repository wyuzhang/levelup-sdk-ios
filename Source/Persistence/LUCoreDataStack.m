#import "LUCoreDataStack.h"
#import "NSArray+LUAdditions.h"

NSString * const LUPersistedObjectsInitialDatabaseFileName = @"LUPersistedObjectsInitial";
NSString * const LUPersistedObjectsStoreDatabaseFileName = @"LUPersistedObjects";

@implementation LUCoreDataStack

#pragma mark - Public Methods (Managed Object Context)

+ (NSManagedObjectContext *)managedObjectContext {
  NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
  managedObjectContext.persistentStoreCoordinator = [self persistentStoreCoordinator];

  return managedObjectContext;
}

#pragma mark - Public Methods (Metadata Access)

+ (NSString *)metadataStringForKey:(NSString *)key {
  NSManagedObjectContext *moc = [self managedObjectContext];
  return [self metadataForObjectContext:moc][key];
}

+ (void)setMetadataString:(NSString *)string forKey:(NSString *)key {
  NSManagedObjectContext *moc = [self managedObjectContext];
  NSMutableDictionary *metadata = [[self metadataForObjectContext:moc] mutableCopy];
  metadata[key] = string;
  [self setMetadata:metadata forObjectContext:moc];
}

#pragma mark - Public Methods (Database URLs)

+ (NSURL *)initialDatabaseURL {
  return [[NSBundle mainBundle] URLForResource:LUPersistedObjectsInitialDatabaseFileName withExtension:@"sqlite"];
}

+ (NSURL *)storeDatabaseURL {
  NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];

  NSString *storeFileName = [LUPersistedObjectsStoreDatabaseFileName stringByAppendingPathExtension:@"sqlite"];
  return [applicationDocumentsDirectory URLByAppendingPathComponent:storeFileName];
}

#pragma mark - Private Methods (Store Access)

+ (NSDictionary *)metadataForObjectContext:(NSManagedObjectContext *)moc {
  return [[moc.persistentStoreCoordinator.persistentStores firstObject] metadata];
}

+ (void)setMetadata:(NSDictionary *)metadata forObjectContext:(NSManagedObjectContext *)moc {
  [[moc.persistentStoreCoordinator.persistentStores firstObject] setMetadata:metadata];
  [moc save:nil];
}

+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  if (![self storeDatabaseExists] || [self initialDatabaseNewerThanStoreDatabase]) {
    [self replaceStoreDatabaseWithInitial];
  }

  NSManagedObjectModel *mom = [NSManagedObjectModel mergedModelFromBundles:nil];
  NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];

  NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption : @YES, NSInferMappingModelAutomaticallyOption : @YES};
  NSError *error;
  if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                configuration:nil
                                                          URL:[self storeDatabaseURL]
                                                      options:options
                                                        error:&error]) {
    NSLog(@"Error while creating persistent store coordinator: %@, %@", error, [error userInfo]);
    abort();
  }

  return persistentStoreCoordinator;
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
